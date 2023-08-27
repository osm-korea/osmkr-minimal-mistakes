---
layout: single
classes: wide
title: 오픈스트리트맵 지도 타일 서버 호스팅하기(도커를 이용한 방법)
permalink: /using-a-docker-container/
toc: false
toc_label: "목차"
author_profile: false
sidebar:
  nav: "sidebar"
---
※ 이 글은 [Switch2OSM 웹 사이트](https://switch2osm.org/serving-tiles/using-a-docker-container/)에서 가져온 내용을 번역, 수정한 것입니다.

임시로 지도 타일 서버를 열어 보고 싶거나, 우분투가 아닌 다른 OS를 사용하거나, 이미 컨테이너화 도구로서 도커를 사용하고 있다면 [도커로 오픈스트리트맵 지도 타일 서버를 열어 보세요](https://github.com/Overv/openstreetmap-tile-server/blob/master/README.md)(도커 컨테이너를 만들어 준 모든 기여자에게 감사드립니다). 이 글에서는 [우분투 18.04 기준 설치법](https://switch2osm.org/serving-tiles/manually-building-a-tile-server-18-04-lts/)을 따라 제작한 컨테이너를 사용합니다.

## 도커

도커를 아직 설치하지 않았다면 설치하세요. 도커 설치법은 인터넷에 검색하면 금방 나옵니다. [이 글](https://www.openstreetmap.org/user/SomeoneElse/diary/45070)을 참고해도 됩니다.

## 오픈스트리트맵 데이터

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

## 도커 설정하기

다운로드한 오픈스트리트맵 데이터를 저장할 도커 볼륨을 만듭니다.

{% highlight shell %}
docker volume create openstreetmap-data
{% endhighlight %}

도커 볼륨을 설치한 후 데이터를 볼륨으로 가져옵니다.

{% highlight shell %}
time docker run -v /home/(계정 이름)/south-korea-latest.osm.pbf:/data.osm.pbf -v openstreetmap-data:/var/lib/postgresql/12/main overv/openstreetmap-tile-server:1.3.10 import
{% endhighlight %}

데이터 파일의 경로는 상대 경로가 아닌 절대 경로여야 합니다. `(계정 이름)`을 적절한 값으로 바꿔 주세요.

데이터를 가져오는 데 걸리는 시간은 로컬 네트워크의 속도와 데이터의 양에 따라 크게 달라집니다. 다행히 대한민국의 OSM 데이터는 그리 크지 않습니다.

문제가 생겼을 때 뜨는 오류 메시지는 다소 모호할 수 있습니다. 데이터 파일을 찾을 수 없을 때는 "... is a directory"가 뜰 수 있습니다. 명령어 앞 부분의 'time'은 설치 및 데이터 가져오기 과정에서 필요하지 않으며, 단순히 소요 시간을 알려주는 용도입니다. 또한 컨테이너 버전 1.3.6에서 PostgreSQL이 업데이트되었기 때문에([참고](https://github.com/Overv/openstreetmap-tile-server/releases/tag/v1.3.6)). 1.3.6 이전 버전에서 생성한 'openstreetmap-data' 볼륨은 그 이상 버전에서 작동하지 않습니다. `docker volume rm openstreetmap-data`로 볼륨을 제거하고 다시 생성해야 합니다.

도커 파일의 내용물을 자세히 보고 싶으시다면 [여기](https://github.com/Overv/openstreetmap-tile-server/blob/master/Dockerfile)를 참고하세요. 타일 ​​URL 및 내부 계정명과 같은 약간의 변경 사항을 제외하고는 '[우분투 18.04에서 타일 서버 구축하기](https://switch2osm.org/serving-tiles/manually-building-a-tile-server-18-04-lts/)'와 거의 일치하는 것을 볼 수 있습니다. 도커 컨테이너 내부와 직접 상호작용할 필요는 없지만 원한다면 `docker exec -it mycontainernumber bash`로 상호작용이 가능합니다.

데이터 가져오기가 완료되면 다음과 같이 표시됩니다.

{% highlight shell %}
Osm2pgsql took 568s overall

real    9m34.378s
user    0m0.030s
sys     0m0.060s
{% endhighlight %}

총 소요 시간을 볼 수 있습니다(이 예시에서는 9분 34초).

실행 중인 타일 서버를 시작하려면 아래 명령어를 입력하세요.

{% highlight shell %}
docker run -p 80:80 -v openstreetmap-data:/var/lib/postgresql/12/main -d overv/openstreetmap-tile-server:1.3.10 run
{% endhighlight %}

타일 서버가 작동하는지 확인하려면 웹 브라우저에 아래 URL을 입력하세요. 세계 지도 그림이 떠야 합니다.

{% highlight shell %}
http://(서버 ip 주소 및 도메인)/tile/0/0/0.png
{% endhighlight %}

## 추가 정보

이 도커 컨테이너는 실제로 여기서 설명한 것보다 훨씬 더 많은 기능을 지원합니다. 업데이트, 성능 조정 등을 자세히 알고 싶으시다면 [여기](https://github.com/Overv/openstreetmap-tile-server/blob/master/README.md)를 참고하세요.

## 지도 타일 보기

[mod_tile의 'extra' 폴더에 있는 "sample_leaflet.html"](https://github.com/SomeoneElseOSM/mod_tile/blob/switch2osm/extra/sample_leaflet.html)을 이용해 지도를 볼 수 있습니다. 해당 파일의 URL에서 'hot'를 'tile'로 바꾸고, 도커 컨테이너를 설치한 컴퓨터의 웹 브라우저에서 해당 파일을 열면 됩니다. 지도 타일을 설치한 서버에 웹 브라우저가 설치되어 잇지 않다면 '127.0.0.1'을 서버의 IP 주소로 바꾼 후 `sample_leaflet.html` 파일을 서버의 /var/www/html에 복사하세요.

다른 영역을 불러오려면 위의 'wget'부터 설치 과정을 반복하면 됩니다. 지도 스타일 설정에 필요한 정적 데이터를 이미 가져왔기 때문에 설치 속도가 더 빨라질 것입니다.
