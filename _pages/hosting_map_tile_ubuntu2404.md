---
layout: single
classes: wide
title: 오픈스트리트맵 지도 타일 서버 호스팅하기(우분투 24.04 기준)
permalink: /hosting-map-tile-ubuntu2404/
toc: false
toc_label: "목차"
author_profile: false
sidebar:
  nav: "sidebar"
---
※ 이 글은 [Switch2OSM 웹 사이트](https://switch2osm.org/serving-tiles/manually-building-a-tile-server-ubuntu-24-04-lts/)에서 가져온 내용을 번역, 수정한 것입니다.

이 글에서는 직접 지도 타일 서버를 구동하는 데 필요한 모든 소프트웨어를 설치하고, 설정 및 구성하는 방법을 설명합니다. 이 지침은 [Ubuntu Linux 24.04](http://www.releases.ubuntu.com/24.04/) (Noble Numbat)용으로 작성되었으며, 2024년 4월에 테스트했습니다.

## 소프트웨어 설치

오픈스트리트맵 타일 서버 스택은 지도 타일 서버를 만들기 위해 서로 유기적으로 작동하는 프로그램 및 라이브러리를 한꺼번에 가리키는 단어입니다. 오픈스트리트맵에서는 흔히 그렇듯이 지도 타일 서버를 만드는 방법은 여러 가지가 있습니다. 또한 구성 요소가 되는 각 소프트웨어마다 대안책이 있으며, 고유한 장단점을 지닙니다. 이 지침서는 기본 OpenStreetMap.org 타일 서버에서 사용되는 것과 유사한 가장 표준적인 방법을 설명합니다.

여기서 설명한 방법은 mod_tile, renderd, mapnik, osm2pgsql, postgresql/postgis 데이터베이스, 총 5가지 주요 구성 요소를 필요로 합니다. mod_tile은 캐시된 타일을 제공하고, 어떤 타일이 아직 캐시되지 않았거나 오래되었다면 다시 렌더링해야 하는지를 결정하는 아파치 모듈입니다. renderd는 렌더링 요청의 부하를 관리하고 원활하게 처리하기 위해 다양한 유형의 요청에 우선 순위를 매기는 대기열 시스템을 제공합니다. mapnik은 실제로 렌더링을 수행하는 소프트웨어 라이브러리로, renderd에서 사용됩니다.

데비안 및 우분투 관리자들이 이들 패키지의 최신 버전을 우분투 24.04에 통합하기 위해 노력해 준 덕분에 이 지침은 이전 버전의 우분투에 비해 다소 짧아졌습니다.

이 지침은 새로 설치된 우분투 24.04 서버에서 작성 및 테스트되었습니다. 일부 소프트웨어의 다른 버전이 이미 설치되어 있는 경우(아마도 이전 버전에서 업그레이드했거나 일부 PPA를 불러오도록 설정한 경우) 명령어에 일부 조정이 필요할 수 있습니다.

이러한 구성 요소를 빌드하려면 먼저 다양한 종속성을 설치해야 합니다.

이 지침의 모든 명령어는 루트가 아닌 사용자의 환경에서 실행한다고 가정합니다. 아래의 모든 작업을 루트 권한으로 시도하지 마세요. 작동하지 않습니다.

{% highlight shell %}
sudo apt update
sudo apt upgrade
sudo apt install screen locate libapache2-mod-tile renderd git tar unzip wget bzip2 apache2 lua5.1 mapnik-utils python3-mapnik python3-psycopg2 python3-yaml gdal-bin npm node-carto postgresql postgresql-contrib postgis postgresql-16-postgis-3 postgresql-16-postgis-3-scripts osm2pgsql net-tools curl
{% endhighlight %}

이 명령어를 실행하면 새 계정이 2개 추가됩니다. 새로운 계정은 `tail /etc/passwd`로 볼 수 있습니다. `postgres`는 렌더링할 데이터를 저장하는 데이터베이스를 관리하는 데 사용하는 계정입니다. `_renderd`는 renderd 데몬에 사용되며, 아래의 많은 명령이 `_renderd` 사용자로 실행되는지 확인해야 합니다.

이제 PostGIS 데이터베이스를 만들어야 합니다. 다양한 오픈스트리트맵 관련 프로그램에서는 기본적으로 `gis` 데이터베이스에 지리공간 데이터가 저장되어 있다고 가정합니다. 꼭 이 가정을 따라야 하는 것은 아니지만, 여기서는 이 가정을 따르도록 하겠습니다. 아래의 `_renderd`는 renderd 데몬을 실행할 사용자와 일치합니다.

{% highlight shell %}
sudo -u postgres -i
createuser _renderd
createdb -E UTF8 -O _renderd gis
{% endhighlight %}

`postgres` 사용자로 접속한 후, `gis`라는 이름의 데이터베이스를 추가합니다. 아래 명령들도 계속해서 `postgres` 사용자로 실행하세요.

{% highlight shell %}
psql
{% endhighlight %}

(`postgres=#` 프롬프트가 나타납니다.)

{% highlight sql %}
\c gis
{% endhighlight %}

(`You are now connected to database ‘gis’ as user ‘postgres’`라는 문구가 표시됩니다.)

{% highlight sql %}
CREATE EXTENSION postgis;
{% endhighlight %}

(`CREATE EXTENSION`이라는 문구가 표시됩니다.)

{% highlight sql %}
CREATE EXTENSION hstore;
{% endhighlight %}

(`CREATE EXTENSION`이라는 문구가 표시됩니다.)

{% highlight sql %}
ALTER TABLE geometry_columns OWNER TO _renderd;
{% endhighlight %}

(`ALTER TABLE`이라는 문구가 표시됩니다.)

{% highlight sql %}
ALTER TABLE spatial_ref_sys OWNER TO _renderd;
{% endhighlight %}

(`ALTER TABLE`이라는 문구가 표시됩니다.)

{% highlight sql %}
\q
{% endhighlight %}

(psql을 종료하고 일반 리눅스 프롬프트로 돌아갑니다.)

{% highlight shell %}
exit
{% endhighlight %}

(위의 `sudo -u postgres -i`를 수행하기 전의 사용자로 돌아갑니다.)

## Mapnik

위에서 Mapnik을 설치했습니다. 다음 명령을 수행해 Mapnik이 올바르게 설치되었는지 확인합니다.

{% highlight python3 %}
python3
>>> import mapnik
>>>
{% endhighlight %}

Python이 두 번째 갈매기형 프롬프트 `>>>`로 오류 없이 응답하면 파이썬에서 성공적으로 Mapnik 라이브러리를 찾은 것입니다. 축하드립니다! 다음 명령을 입력하면 파이썬을 종료할 수 있습니다.

{% highlight python3 %}
>>> quit()
{% endhighlight %}

## 스타일시트 구성하기

이제 필요한 모든 소프트웨어가 설치되었으므로 스타일시트를 다운로드하고 구성해야 합니다.

여기서는 openstreetmap.org 웹사이트의 '표준(standard)' 지도에서 사용하는 스타일을 사용하도록 하겠습니다. 표준 지도 스타일은 잘 문서화되어 있고, (비라틴 문자권을 포함해서) 전 세계 어디에서나 작동하는 것을 목적으로 하기 때문입니다. 그러나 표준 지도 스타일에도 몇 가지 단점이 있습니다. 전 세계 어디에서나 작동한다는 것은 다시 말해 전 세계에서 작동하도록 설계된 '절충안'이라는 뜻이 되며, 이해하고 수정하기가 매우 복잡합니다.

웹 상의 "OpenStreetMap Carto"는 [https://github.com/gravitystorm/openstreetmap-carto/](https://github.com/gravitystorm/openstreetmap-carto/)에 저장되어 있으며, 자체 설치 지침은 [http://github.com/gravitystorm/openstreetmap-carto/blob/master/INSTALL.md](http://github.com/gravitystorm/openstreetmap-carto/blob/master/INSTALL.md)에서 볼 수 있습니다. 그러나 이 지침서에서는 실제로 수행해야 하는 모든 작업을 다룰 것입니다.

여기서 우리는 루트가 아닌 사용자 계정의 홈 디렉토리 안에 `src` 디렉토리를 만들고, 그 안에 스타일시트의 세부 정보를 저장한다고 가정합니다. `_renderd` 사용자가 해당 디렉토리에 접근할 수 있도록 접근 권한을 변경합니다.

{% highlight shell %}
mkdir ~/src
cd ~/src
git clone https://github.com/gravitystorm/openstreetmap-carto
cd openstreetmap-carto
{% endhighlight %}

다음으로 적합한 버전의 'carto' 컴파일러를 설치합니다.

{% highlight shell %}
sudo npm install -g carto
carto -v
{% endhighlight %}

최소한 1.2.0 버전 이상이어야 합니다.

그런 다음 carto 프로젝트 파일을 Mapnik이 이해할 수 있는 형태로 변환합니다.

{% highlight shell %}
carto project.mml > mapnik.xml
{% endhighlight %}

/home/`사용자명`/src/openstreetmap-carto/mapnik.xml에 Mapnik XML 스타일시트가 생성됩니다.

## 지도 데이터 불러오기

다음 명령어로 지리 데이터를 다운로드합니다.

### 군사 시설 없는 한반도 지도

{% highlight shell %}
mkdir ~/data
cd ~/data
wget https://tiles.osm.kr/download/korea-latest-non-military.osm.pbf
{% endhighlight %}

### 군사 시설이 포함된 대한민국 지도 원본

{% highlight shell %}
mkdir ~/data
cd ~/data
wget https://download.geofabrik.de/asia/south-korea-latest.osm.pbf
{% endhighlight %}

[https://download.geofabrik.de/asia/south-korea.html](https://download.geofabrik.de/asia/south-korea.html)로 들어가서 "This file was last modified"로 시작하는 문장에 표기된 날짜(예시: "2022-04-22T20:21:40Z")를 기록해 두세요. 나중에 다른 기여자들이 오픈스트리트맵을 편집할 때 이를 로컬 데이터베이스에 반영하려면 이 날짜 값이 필요합니다.

다음으로 `_renderd` 사용자가 스타일시트에 접근할 수 있는지 확인해야 합니다. 접근 권한을 주려면 다운로드한 위치에 `_renderd` 계정이 접근할 수 있는 권한이 필요합니다. 기본적으로 `_renderd` 계정은 사용자의 홈 디렉토리에 접근할 수 있는 권한이 없습니다. `src` 디렉토리가 사용자 계정 아래에 있는 경우 아래 명령어를 실행하세요.

{% highlight shell %}
chmod o+rx ~
{% endhighlight %}

권한을 부여하고 싶지 않으시다면 `src` 디렉토리를 다른 곳으로 이동하고, 뒤이은 명령에서 스타일시트 파일의 경로를 수정해 주면 됩니다.

다음 명령은 다운로드한 오픈스트리트맵 데이터를 데이터베이스에 삽입하는 명령입니다. 이 단계는 디스크 입출력 대역폭을 많이 사용(I/O 집약적)합니다. 전 세계의 데이터를 삽입하는 데는 하드웨어에 따라 몇 시간, 며칠, 심지어는 몇 주가 걸릴 수도 있습니다. 추출물의 크기가 작을수록 삽입 시간이 훨씬 더 빨라집니다. 또한 시스템의 가용 메모리에 맞도록 -C 값을 조정해 줘야 할 수도 있습니다. 이 과정에서 `_renderd` 사용자를 사용합니다.

{% highlight shell %}
sudo -u _renderd osm2pgsql -d gis --create --slim  -G --hstore --tag-transform-script ~/src/openstreetmap-carto/openstreetmap-carto.lua -C 2500 --number-processes 1 -S ~/src/openstreetmap-carto/openstreetmap-carto.style ~/data/korea-latest-non-military.osm.pbf
{% endhighlight %}

※ 위에서 '군사 시설 없는 한반도 지도' 대신 '군사 시설이 포함된 대한민국 지도 원본'을 다운로드했다면 맨 마지막 인자의 경로를 `~/data/south-korea-latest.osm.pbf`로 바꿔 주세요.

각 옵션의 의미를 알아 두면 좋습니다.

{% highlight shell %}
-d gis
{% endhighlight %}

작업할 데이터베이스(`gis`가 기본값이었지만 여기서는 명시해 줘야 함).

{% highlight shell %}
--create
{% endhighlight %}

기존 데이터베이스에 데이터를 추가하는 것이 아닌 빈 데이터베이스에 데이터를 불러옵니다.

{% highlight shell %}
--slim
{% endhighlight %}

osm2pgsql은 'slim` 외에도 다른 테이블 레이아웃을 사용할 수 있습니다. 'slim' 테이블은 렌더링에 적합합니다.

{% highlight shell %}
-G
{% endhighlight %}

다중 다각형을 처리하는 방식을 결정합니다.

{% highlight shell %}
--hstore
{% endhighlight %}

명시적 데이터베이스 열이 없는 태그를 렌더링에 사용할 수 있습니다.

{% highlight shell %}
--tag-transform-script
{% endhighlight %}

태그 처리에 사용할 lua 스크립트를 정의합니다. 스타일 자체가 오픈스트리트맵 태그를 처리하기 전에 여기서 명시해 준 lua 스크립트를 통해 태그를 전처리합니다. 이로써 스타일의 논리 구조를 잠재적으로 훨씬 간단하게 만듭니다.

{% highlight shell %}
-C 2500
{% endhighlight %}

가져오기 과정을 위해 osm2pgsql에 2.5 GB의 메모리를 할당합니다. 메모리가 적은 경우 값을 줄여서 시도할 수 있으며, 메모리 부족으로 가져오기 과정이 중단되는 경우 값을 키우거나 추출물의 크기를 줄여야 합니다.

{% highlight shell %}
--number-processes 1
{% endhighlight %}

CPU 스레드 하나를 사용합니다. 사용 가능한 코어가 더 있다면 값을 늘릴 수 있습니다.

{% highlight shell %}
-S
{% endhighlight %}

데이터를 데이터베이스로 가져오는 방법을 규정하는 스타일 파일을 정의합니다.

마지막 인자는 불러올 데이터 파일입니다.

이 명령이 성공적으로 끝난다면 `osm2pgsql take 163s (2m 43s) overall`과 같은 식의 문구가 표시됩니다.

## 색인 생성하기

버전 5.3.0부터 일부 추가 인덱스를 [수동으로 적용해야 합니다](https://github.com/gravitystorm/openstreetmap-carto/blob/master/CHANGELOG.md#v530---2021-01-28).

{% highlight shell %}
cd ~/src/openstreetmap-carto/
sudo -u _renderd psql -d gis -f indexes.sql
{% endhighlight %}

`CREATE INDEX`라는 문구가 16번 표시되어야 합니다.

## 셰이프파일(Shapefile) 다운로드하기

지도를 만드는 데 사용하는 데이터의 대부분은 위에서 다운로드한 오픈스트리트맵 데이터 파일에서 직접 가져오지만 저배율에서의 국가 경계와 같은 데이터는 다른 셰이프파일에서 가져와야 합니다. 이전에 사용한 것과 동일한 계정을 사용해 셰이프파일을 다운로드하고 색인을 생성합니다.

{% highlight shell %}
cd ~/src/openstreetmap-carto/
mkdir data
sudo chown _renderd data
sudo -u _renderd scripts/get-external-data.py
{% endhighlight %}

이 과정에서 많은 용량의 파일을 여러 개 다운로드하며, 이 때문에 다소 시간이 걸릴 수 있습니다. 명령이 실행 중일 때 화면에 문구가 많이 표시되지 않습니다. 일부 데이터는 데이터베이스로 직접 이동하고, 일부는 `openstreetmap-carto` 디렉토리 안의 `data` 디렉토리로 이동합니다. 이 과정에서 문제가 발생한 경우 Natural Earth 데이터의 주소가 바뀌었을 수 있습니다. 자세한 사항은 Natural Earth에서 이 문제 및 기타 문제를 살펴보세요. Natural Earth의 다운로드 주소를 변경해야 하는 경우 [이 파일](https://github.com/gravitystorm/openstreetmap-carto/blob/master/external-data.yml)의 복사본을 편집해야 합니다.

## 글꼴

Carto 버전 5.6.0 이상에서는 글꼴을 수동으로 설치해야 합니다.

{% highlight shell %}
cd ~/src/openstreetmap-carto/
scripts/get-fonts.sh
{% endhighlight %}

이 과정을 거치지 않으면 비라틴 문자가 제대로 표시되지 않습니다.

또한 기본적으로 한자의 자형은 일본식으로 설정되어 있습니다. 이를 한국식으로 바꾸려면 아래 명령어를 실행하세요.

{% highlight shell %}
~/src/openstreetmap-carto/scripts/change-fonts-cjk.sh ko
{% endhighlight %}

`ko`(한국) 대신 `ja`(일본 신자체), `zh-Hans`(중국 간화자), `zh-Hant-TW`(대만 정체자), `zh-Hant-HK`(홍콩 정체자)를 선택할 수 있습니다.

## 웹 서버의 렌더링 속성 설정하기

우분투 24.04의 `renderd` 구성 파일은 `/etc/renderd.conf`입니다. nano와 같은 텍스트 편집기로 해당 파일을 여세요.

{% highlight shell %}
sudo nano /etc/renderd.conf
{% endhighlight %}

파일 끝에 다음 줄을 추가합니다.

{% highlight yaml %}
[s2o]
URI=/hot/
XML=/home/accountname/src/openstreetmap-carto/mapnik.xml
HOST=localhost
TILESIZE=256
MAXZOOM=20
{% endhighlight %}

XML 파일 /home/`사용자명`/src/openstreetmap-carto/mapnik.xml의 위치를​ 컴퓨터 상의 실제 위치로 적절히 수정해 주어야 합니다. 원하는 경우 `[s2o]` 및 `URI=/hot/`도 수정할 수 있습니다. 한 서버에서 두 개 이상의 타일 집합을 렌더링하려면 서로 다른 지도 스타일을 참조하도록 `[s2o]`와 같이 별도의 부분을 추가하면 됩니다. 기본 `gis` 데이터베이스 대신 다른 데이터베이스를 참조하도록 하려면 그렇게 할 수 있지만 이 문서의 범위를 벗어나므로 설명은 생략하겠습니다. 메모리가 2 GB 정도밖에 없다면 `num_threads`도 2로 줄이는 것이 좋습니다. 여기에서 생성된 타일을 OpenStreetMap.org의 HOT 타일 레이어의 자리에 놓고 더 쉽게 사용할 수 있도록 `URI=/hot/`를 선택했습니다. 물론 다른 주소 값을 입력해도 됩니다.

이 지침을 처음 작성했을 때 우분투 24.04에서 제공하는 Mapnik의 버전은 3.1이었고, 따라서 파일의 `[mapnik]` 부분의 `plugins_dir` 설정은 `/usr/lib/mapnik/3.1/input`이었습니다. 이 `3.1`은 앞으로 또 바뀔 수 있습니다.

{% highlight shell %}
An error occurred while loading the map layer 's2o': Could not create datasource for type: 'postgis' (no datasource plugin directories have been successfully registered)  encountered during parsing of layer 'landcover-low-zoom'
{% endhighlight %}

만약 위와 같은 오류가 발생한다면 '/usr/lib/mapnik'에 어떤 버전의 디렉토리가 있는지 확인하고, '/usr/lib/mapnik/`(버전)`/input' 디렉토리를 찾아 `postgis.input` 파일이 있는지 확인하세요.

이로써 타일 렌더링 요청에 `renderd`가 어떻게 반응해야 하는지 설정해 주었습니다. 이제 아파치 웹 서버에서 `renderd`에 타일 렌더링 요청을 보내도록 설정해야 합니다. 안타깝게도 해당 구성은 최신 버전 mod_tile에서 제거되었습니다. 아래 명령을 통해 직접 설정 파일을 넣어 주세요.

{% highlight shell %}
cd /etc/apache2/conf-available/
sudo wget https://raw.githubusercontent.com/openstreetmap/mod_tile/python-implementation/etc/apache2/renderd.conf
sudo a2enconf renderd
sudo systemctl reload apache2
{% endhighlight %}

## 디버그 메시지를 볼 수 있는지 확인하기

이 시점에서 (오류를 비롯한) 타일 렌더링 과정을 눈으로 볼 수 있다면 정말 유용할 것입니다. 최신 mod_tile 버전에서는 이 설정이 기본적으로 꺼져 있습니다. 설정을 켜려면 다음 명령어로 설정 파일을 여세요.

{% highlight shell %}
sudo nano /usr/lib/systemd/system/renderd.service
{% endhighlight %}

파일에 아래 문구가 없다면 `[Service]` 뒤에 해당 문구를 추가해 주세요.

{% highlight shell %}
Environment=G_MESSAGES_DEBUG=all
{% endhighlight %}

그러고 나서 아래 명령어를 실행하세요.

{% highlight shell %}
sudo systemctl daemon-reload
sudo systemctl restart renderd
sudo systemctl restart apache2
{% endhighlight %}

## Apache 설정하기

`/var/log/syslog` 파일에 `renderd` 서비스의 메시지가 기록되어야 합니다. 처음에는 몇 가지 글꼴 경고가 표시됩니다. 지금은 이 문제를 걱정하지 않으셔도 됩니다.

이제 아래 명령어를 실행하세요.

{% highlight shell %}
sudo /etc/init.d/apache2 restart
{% endhighlight %}

syslog에 아래와 같은 메시지가 표시되어야 합니다.

{% highlight shell %}
Apr 23 11:14:10 servername apachectl[2031]: [Sat Apr 23 11:14:10.190678 2024] [tile:notice] [pid 2031:tid 140608477239168] Loading tile config s2o at /hot/ for zooms 0 - 20 from tile directory /var/cache/renderd/tiles with extension .png and mime type image/png
{% endhighlight %}

이제 웹 브라우저에 `http://(서버 ip 주소)/index.html`에 접속하세요. "Apache2 우분투 기본 페이지"가 ​표시되어야 합니다.

할당될 IP 주소를 모를 경우 `ifconfig` 명령어로 찾을 수 있습니다. 네트워크 구성이 너무 복잡하지 않다면 '127.0.0.1'이 아니라 '내부 ip 주소'가 뜰 수도 있습니다. 호스팅 제공 업체의 서버를 사용하는 경우 서버의 내부 주소가 외부 주소와 다를 가능성이 있지만, 해당 외부 IP 주소는 이미 여러분이 알고 계실 것입니다.

이는 'http'(포트 80) 사이트일 뿐이라는 점에 유의하십시오. https를 활성화하려면 Apache 구성을 조금 더 만져야 하지만, 이는 지침서의 범위를 벗어납니다. 그러나 "Let's Encrypt"를 사용해 인증서를 발급하면 해당 설정 과정에서 Apache HTTPS 사이트도 구성할 수 있습니다.

그런 다음 웹 브라우저에서 `http://(서버 ip 주소)/hot/0/0/0.png`에 접속하세요.

위에서 `URI=/hot/`을 수정했다면 물론 hot가 아닌 수정한 값을 넣어야 합니다. 작은 세계 지도가 보일 것입니다. 지도가 보이지 않는다면 표시되는 오류를 조사하세요. 권한 오류이거나 위의 지침에서 일부 단계를 실수로 누락했을 가능성이 높습니다. 타일이 나오지 않고 다른 오류가 다시 발생한다면 전체 출력을 저장한 후, [오픈스트리트맵 커뮤니티 포럼 한국/조선(Korea) 카테고리](https://community.openstreetmap.org/c/communities/ko/74) 혹은 [오픈스트리트맵 한국 커뮤니티 텔레그램 채팅방](https://t.me/OSMKorea)에 질문을 올려 주세요.

## 지도 타일 보기

지도 타일을 보기 위해 아주 간단한 지도를 볼 수 있는 html 파일 `sample_leaflet.html`을 속여서 사용하겠습니다.

{% highlight shell %}
cd /var/www/html
sudo wget https://raw.githubusercontent.com/SomeoneElseOSM/mod_tile/switch2osm/extra/sample_leaflet.html
sudo nano sample_leaflet.html
{% endhighlight %}

IP 주소가 '127.0.0.1'이 아니라 서버 ip 주소와 일치하도록 수정하세요. 그러면 다른 사람이 이 서버에 접속할 수 있습니다. 그러고 나서 `http://(서버 ip 주소)/sample_leaflet.html`에 접속하세요.

초기 지도 표시에는 약간의 시간이 걸립니다. 지도를 확대 및 축소할 수 있지만 서버 속도에 따라 일부 타일은 브라우저의 속도에 맞춰서 렌더링할 수 없기 때문에 처음에는 일부 구역이 회색으로 표시될 수 있습니다. 그러나 일단 지도 타일 생성이 완료되면 나중에 동일한 지역을 불러올 때 빠르게 처리할 수 있습니다. `/var/log/syslog`에 타일 생성 요청이 표시되어야 합니다. 타일 요청을 보려면 ssh 연결에서 다음 명령어를 입력하세요.

{% highlight shell %}
tail -f /var/log/syslog | grep " TILE "
{% endhighlight %}

(" TILE " 주변의 공백에 유의하세요.)

그러면 타일이 요청될 때마다 한 줄이 표시되고, 요청 하나가 끝날 때마다 또 한 줄이 표시됩니다.

원한다면 `/etc/apache2/conf-available/renderd.conf`에서 `ModTileMissingRequestTimeout` 설정을 10초에서 30초 또는 60초로 늘려 타일이 백그라운드에서 렌더링될 때까지 기다리는 시간을 늘릴 수 있습니다. 이 시간이 초과하도록 타일이 생성되지 않으면 회색 타일을 사용자에게 전송합니다. 설정을 변경한 후에는 `sudo service renderd restart`와 `sudo service apache2 restart`를 항상 실행해 주세요.

축하드립니다. 새 타일 서버를 사용하는 웹 사이트를 만들려면 [Leaflet으로 웹 사이트에 오픈스트리트맵 지도 띄우기](https://osm.kr/using-osm-with-leaflet/) 문서를 참고하세요.
