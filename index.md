---
title: "OpenStreetMap Korea"
layout: splash
read_time: false
date: 2021-09-03T11:48:41+09:00
#header:
#  overlay_color: "#000"
#  overlay_filter: "0.3"
#  overlay_image: /assets/image/logo_osmkorea.png
excerpt: "누구나 만들 수 있는, 누구나 이용할 수 있는 지도 데이터베이스 **오픈스트리트맵(OpenStreetMap)**을 만들어 가는  사람들"
feature_row:
  - image_path: /assets/image/history/2004_osm2x.png
    image_size: 33%
    alt: "OSM Server at 2004"
    title: "한국 오픈스트리트맵 커뮤니티의 역사"
    excerpt: '2004년 오픈스트리트맵의 탄생부터 현재까지의 역사를 알아봅니다.'
    url: "/history"
    btn_label: "더 보기"
    btn_class: "btn--primary"

  - image_path: /assets/image/logo_osmkorea.png
    image_size: 33%
    alt: "Events of OSM Korea"
    title: "한국 오픈스트리트맵 커뮤니티에서 진행한 이벤트"
    excerpt: '대한민국에서 개최된 오픈스트리트맵 관련 이벤트를 소개합니다.'
    url: "/event"
    btn_label: "더 보기"
    btn_class: "btn--primary"

  - image_path: /assets/image/editing.png
    image_size: 33%
    alt: "The editing window"
    title: "오픈스트리트맵에 기여하기"
    excerpt: '직접 오픈스트리트맵에 기여해 보세요!'
    url: "https://osm.org/"
    btn_label: "기여하기"
    btn_class: "btn--primary"

  - image_path: /assets/image/weeklyosm.png
    alt: "The WeeklyOSM logo"
    title: "주간OSM"
    excerpt: '매주 일요일 저녁마다 새로운 소식이 올라옵니다!'
    url: "https://weeklyosm.eu/"
    btn_label: "보러 가기"
    btn_class: "btn--primary"

  - image_path: /assets/image/taginfo3_2x.png
    alt: "The taginfo logo"
    title: "한국판 taginfo"
    excerpt: '대한민국 오픈스트리트맵 데이터베이스의 모든 것을 알 수 있습니다.'
    url: "https://taginfo.osm.kr/"
    btn_label: "보러 가기"
    btn_class: "btn--primary"

  - image_path: /assets/image/tileserver.png
    alt: "logic of a tile server"
    title: "군사 시설을 제외한 오픈스트리트맵 지도 타일 서버"
    excerpt: 'osm.kr 자체 서버를 활용한 한반도 오픈스트리트맵 지도 타일 서버입니다. 타일 생성 속도가 매우 느리며, 너무  많은 타일을 생성하면 서버 전체가 느려질 수 있습니다. 군사 시설 없는 데이터베이스는 [tiles.osm.kr/download](https://tiles.osm.kr/download)에서 받을 수 있습니다.'
    url: "https://tiles.osm.kr/"
    btn_label: "보러 가기"
    btn_class: "btn--primary"
---

{% include map.html %}

## 오픈스트리트맵(OpenStreetMap)이란?

<!--![OSM Carto에서 본 경복궁](/assets/image/buan.png){: .align-right }-->

[**오픈스트리트맵(OpenStreetMap)**](http://osm.org)은 누구나 자유롭게 지도를 만들고, 제약 없이 자유롭게 지도를 이용하기 위한 목적으로 2004년에 시작된 국제 프로젝트입니다. 정확히 말해 오픈스트리트맵은 단순한 지도라기보다는 **지리공간 데이터베이스**이기 때문에 일반적인 지도에서 볼 수 있는 도로, 건물, 식당뿐만 아니라 등산로의 난이도, 등대의 밝기, 식생과 같은 세세한 정보를 올리고 공유할 수도 있습니다.

한편 한국에서 활동하는 오픈스트리트맵 기여자들이 모여 **오픈스트리트맵 한국(OpenStreetMap Korea)**이라는 커뮤니티를 만들었습니다. 비록 커뮤니티에 소속되지 않고 오픈스트리트맵에 기여하는 것도 가능하지만, 오픈스트리트맵이라는 공통된 관심사를 가진 사람들끼리 소통하면서 활동한다면 혼자서 대한민국 전역을 매핑해야 한다는 의무감, 좌절감 대신 소속감을 느끼게 될 것입니다.

과거 한국의 오픈스트리트맵 데이터는 매우 열악했고 현재도 부족하지만, 편집하는 만큼 발전한다는 오픈스트리트맵의 특성 덕에 상용 지도보다 훨씬 더 발전할 수 있는 여지가 있습니다. 예컨대 상단의 지도는 오픈스트리트맵에서 본 부안군 읍내의 모습입니다. 현재 배율에서는 상점이 점으로만 표시되어 있지만, 확대하면 상점의 종류나 이름도 나타나 많은 정보를 제공합니다. 오픈스트리트맵 데이터는 지도 이미지 외 다양한 목적으로도 활용할 수 있기 때문에 여기서 도로만 걸러내 표시한다거나, 근처 약국까지 이동하는 데 걸리는 시간을 시각화할 수도 있습니다.

[자세히 보기](/about)

## 네이버 지도나 카카오맵이 있는데, 왜 오픈스트리트맵이 필요한가요?

맞습니다. 실제로 네이버 지도와 카카오맵의 서비스는 최고 수준이죠. 전국을 커버하는 상세한 지도, 빠른 업데이트, 방방곳곳을 집 안에서 돌아볼 수 있도록 해 주는 거리뷰까지, 지도로서 훌륭한 점들을 많이 가지고 있습니다.

그러나 네이버 지도, 카카오맵, 구글 지도, 국토교통부 지도를 비롯한 수많은 지도 서비스는 지도 '이미지'만을 제공해 줍니다. 기업은 차치하고, 심지어 공공기관에서도 지도 '데이터베이스'를 직접 제공하지는 않습니다. 반면 오픈스트리트맵은 엄밀하게 '지도'가 아니라 '지리공간 데이터베이스'입니다.

데이터베이스 원본이 있기 때문에 대중교통 노선을 보여주는 지도([Andy Allan](https://wiki.openstreetmap.org/wiki/User:Gravitystorm)의 [Transport Map](https://wiki.openstreetmap.org/wiki/Transport_Map)), 사이클리스트를 위한 지도([Phyk](hhttps://wiki.openstreetmap.org/wiki/User:Phyks)와 [Florimondable](https://wiki.openstreetmap.org/wiki/User:Florimondable)의 [CycleOSM](https://wiki.openstreetmap.org/wiki/CyclOSM)), 인도주의 목적에 특화된 지도(Yohan Boniface 등의 [Humanitarian](https://wiki.openstreetmap.org/wiki/Humanitarian_map_style)), 등대의 위치와 전등의 색상, 점멸 주기를 시각적으로 구현한 등대 지도([geodienst](https://github.com/geodienst)의 [Beacon map](https://geodienst.github.io/lighthousemap/)), [놀이기구가 있는 공원 지도](https://armd-02.github.io/Playgrounds/#16.5/35.16259/126.86215) 등등, 상상할 수 없을 정도로 다양한 지도를 오픈스트리트맵 데이터베이스로 만들 수 있습니다. 우리가 알고 있던 기존의 지도 서비스로는 불가능했던 일입니다.

또한 수정 내역이 데이터베이스에 즉각 반영됩니다[^1]. 물론 네이버 지도 등에도 사용자가 수정 **요청**을 제출할 수 있습니다. 그러나 말 그대로 '요청'이기 때문에 처리도 오래 걸리고, 정당한 요청임에도 불구하고 반려되는 경우도 부지기수입니다. 만약 자신의 사업체를 지도에 등록하고 싶은 수준이라면 이 정도로도 충분하지만, 조금 더 적극적으로 지도에 기여하거나 직접 지도를 적극적으로 만들어 보고 싶으시다면 오픈스트리트맵이 훌륭한 대안이 될 수 있습니다.

지리 또는 공간에 관련된 정보라면 어떤 것이든 오픈스트리트맵에 집어넣을 수 있다는 장점도 있습니다. 2004년에 오픈스트리트맵이 처음 생겨났을 때, [코셔 푸드의 취급 여부](https://wiki.openstreetmap.org/wiki/Key:diet:kosher), [백신 접종소](https://wiki.openstreetmap.org/wiki/Proposed_features/Tag:healthcare%3Dvaccination_centre), [승마장의 탑승 시설 및 휴식 장소](https://www.openstreetmap.org/user/valhikes/diary/401483), [가스관 및 전선이 묻힌 자리를 알려주는 표지판](https://wiki.openstreetmap.org/wiki/Key:utility), [이웃한 층에 비해 상대적으로 횡방향 저항 능력이 떨어지는 층](https://wiki.openstreetmap.org/wiki/Key:building:soft_storey)을 오픈스트리트맵에 나타낼 수 있을 것이라고 생각한 사람이 있었을까요? 누군가에게는 매우 중요하지만 다른 지도에서는 볼 수 없는 이러한 정보도 오픈스트리트맵은 수용할 수 있습니다. 이러한 오픈스트리트맵의 특성 덕분에 [국경없는의사회](https://msf.or.kr/)를 비롯한 수많은 구호 단체가 오픈스트리트맵에 열심히 기여하고, 그 결과물을 매우 유용하게 활용하고 있습니다[^2]. 참고로 국경없는의사회에서 진행하는 [Missing Maps](https://msf.or.kr/missingmaps/m/index.html#s4)에 참여하는 것도 오픈스트리트맵에 기여하는 방법입니다!

![OSM Carto에서 본 경복궁](/assets/image/building.png){: .align-right width="400"}

마지막으로 전 세계의 모든 지리 데이터를 통일된 규격으로 이용할 수 있다는 장점이 있습니다. 만약 오픈스트리트맵을 이용하지 않는다면 각 국가별로 도로/건물 데이터 집합을 다운로드해 일일이 합쳐야 한다는 문제가 있습니다. 오픈스트리트맵에서 도로는 전 세계 어느 곳에서나 [`highway=*`](https://taginfo.openstreetmap.org/keys/highway#map) 태그를 사용하고, 건물 또한 [`building=*`](https://taginfo.openstreetmap.org/keys/building#map) 태그를 사용합니다. 예컨대 한국 지역 오픈스트리트맵을 분석해 건물의 밀도를 시각화하는 프로그램을 짰다면, 이 프로그램을 그대로 다른 나라에 적용할 수 있습니다. 오픈스트리트맵을 사용하지 않는다면 입력 데이터를 해석하는 방식을 나라마다 바꿔 줘야 할 것입니다.

## 오픈스트리트맵은 현재 어디에서 활용되고 있나요?

오픈스트리트맵 하면 [포켓몬 고](https://pokemongolive.com/?hl=ko)를 떠올리는 분이 많으실 겁니다. 국내에서는 포켓몬 고로 오픈스트리트맵이 유명해지기도 했지요. 비단 포켓몬 고뿐만 아니라 같은 개발사에서 개발한 [인그레스](https://www.ingress.com/), [피크민 블룸](https://pikminbloom.com/ko/)도 오픈스트리트맵 데이터로 지도를 생성합니다. 포켓몬 고를 하다가 여러분이 사는 지역의 지도가 다소 부실하다 느끼신다면 참지 말고 직접 기여하셔도 됩니다! 이렇게 직접 기여해 주신 분들 덕분에 국내 오픈스트리트맵은 2017년 당시에 비해 눈부신 성장을 거두었습니다.

페이스북/인스타그램 앱의 지도도 오픈스트리트맵 기반입니다. 마이크로소프트, 애플, 아마존, 메타(舊 페이스북)와 같은 기업들은 경쟁사인 구글의 지도를 활용하는 대신, 소유권이 독점되지 않은 오픈스트리트맵을 사용합니다. 동시에 오픈스트리트맵을 개선하기 위해 자금과 인력을 꾸준히 지원하고 있습니다.

가민(Garmin)의 GPS 수신기에도 오픈스트리트맵을 탑재할 수 있습니다.

학교 교육에 오픈스트리트맵을 접목하기도 합니다. 오픈스트리트맵 편집을 통해 공간 감각 및 한국의 다양한 지리적 특성을 교과서 외에서 [탐구해볼 수도 있고](https://www.kci.go.kr/kciportal/ci/sereArticleSearch/ciSereArtiView.kci?sereArticleSearchBean.artiId=ART002624817), [YouthMapper](https://www.youthmappers.org/)는 전 세계 72개국 370개 대학교에 설치된 동아리 연합체로, 다함께 오픈스트리트맵을 편집하면서 다양한 사회적 문제를 찾거나 구호 기관에 직접적으로 기여하는 일을 합니다.[^3] 실제로 서유럽권은 학교 내에서 오픈스트리트맵 편집을 실습하는 경우가 많습니다. 자세한 교육 방법은 [위키](https://wiki.openstreetmap.org/wiki/Education)를 참고하세요.

연구 분야에서는 15분 도시 구현이나 배리어 프리 시설 구축 방안 연구를 비롯한 다양한 논문에서 오픈스트리트맵 데이터를 사용합니다. 오픈스트리트맵은 저작권 문제가 없고, 원하는 형태로 데이터를 가공하고, 거르고, 분석할 수 있기 때문입니다. 당장 구글 지도는 캡처를 금지하기 때문에 논문에 사용할 수 없고, 일부 데이터만 선별적으로 제공하는 옵션도 없습니다. 연구 분야에 오픈스트리트맵을 사용하는 방법은 [위키](https://wiki.openstreetmap.org/wiki/Research)를 참고하세요.

유럽권에서는 아예 오픈스트리트맵 데이터를 시청이나 소방서와 같은 공공기관에서 적극적으로 업무에 활용하고 있습니다. 한국에서는 그 정도까지는 아니지만, [원주시 부름버스 앱](https://apps.apple.com/kr/app/%EB%B6%80%EB%A6%84%EB%B2%84%EC%8A%A4/id1661585789)을 비롯한 몇몇 서비스에서 오픈스트리트맵 지도를 이용합니다.

또한 2022년 말에 출범한 [오버추어 지도 재단(Overture Maps Foundation)](https://overturemaps.org/)에서 제공하는 지도의 대부분도 오픈스트리트맵으로 이루어져 있습니다.

## 오픈스트리트맵에 기여하려면 어떻게 해야 하죠?

지도를 만든다고 생각하니 막연하게 어렵게 느껴질 수 있습니다. 뭔가 전문가만 할 수 있는 일 같은 느낌도 들고요. 실제로 과거에는 [JOSM](https://josm.openstreetmap.de/)과 같은 컴퓨터 프로그램으로만 오픈스트리트맵을 편집할 수 있었습니다.

그러나 시대가 바뀐 지금, [Every Door](https://every-door.app/)나 [Organic Maps](https://organicmaps.app/) 앱[^4]으로 자주 가는 식당을 지도에 찍거나 [StreetComplete](https://streetcomplete.app/) 앱으로 도로의 포장재 정보를 추가하는 행위 등을 통해 누구나 사전 지식 없이 오픈스트리트맵을 편집할 수 있게 되었습니다.

### 컴퓨터에서 편집하기

- [iD 편집기](https://learnosm.org/ko/beginner/id-editor/): 오픈스트리트맵 홈페이지에서 바로 이용할 수 있어서 가장 유명합니다. 입문 난이도도 쉬우면서 다양한 기능이 있어 편리하게 이용할 수 있습니다.
- [JOSM](https://learnosm.org/ko/josm/start-josm/): iD와는 다르게 직접 설치해야 하지만, 성능이 낮은 컴퓨터에서도 iD보다 원활하게 작동하고 플러그인을 통해 수많은 기능을 탑재할 수 있다는 이점이 있습니다.
- [Rapid](https://rapideditor.org/): 메타(舊 페이스북)에서 개발한 AI 보조 편집기입니다. 인공지능으로 생성된 도로와 건물을 손쉽게 오픈스트리트맵에 추가할 수 있는 편집기입니다. iD와 동일한 디자인 덕분에 누구나 쉽게 이용할 수 있습니다.
- [포틀래치(Potlatch)](https://wiki.openstreetmap.org/wiki/Potlatch): 현재는 사용자가 많지 않지만, 현존하는 오픈스트리트맵 편집기 중 가장 역사가 오래되었으며, 많은 골수 팬을 보유하고 있습니다.

### 휴대폰에서 편집하기

- [베스푸치(Vespucci)](https://wiki.openstreetmap.org/wiki/Vespucci)(안드로이드): 범용 오픈스트리트맵 편집기입니다.
- [StreetComplete](https://wiki.openstreetmap.org/wiki/StreetComplete)(안드로이드): 사전 지식 없이 오픈스트리트맵에 상점 영업 시간, 도로 포장재, 건물의 층수 등을 손쉽게 터치 몇 번으로 추가할 수 있는 편집기입니다.
- [Go Map!](https://wiki.openstreetmap.org/wiki/Go_Map!!)(iOS): 안드로이드에 베스푸치가 있다면, iOS에는 Go Map!이 있습니다.
- [Every Door](https://wiki.openstreetmap.org/wiki/Every_Door)(안드로이드 및 iOS): 상점이나 소화기, 자동심장충격기(AED)와 같은 지물을 손쉽게 추가할 수 있는 편집기입니다.

이 외에도 고급 사용자나 특수 목적을 위한 편집기들이 매우 많습니다. 자세한 정보는 [오픈스트리트맵 위키](https://wiki.openstreetmap.org/wiki/Editors)를 참고하세요.

지도를 편집하는 방법을 자세히 알고 싶으시다면 [LearnOSM](https://learnosm.org/ko/)을 읽어 보세요. 아직 한국어로 번역되지 않은 부분도 있지만, 오픈스트리트맵을 처음 접하는 초보자에게는 충분할 것입니다. 즐거운 매핑 하시길 바랍니다!

## 오픈스트리트맵 데이터는 어떻게 이용하나요?

기본적으로 오픈스트리트맵은 지도 이미지의 형태가 아닌 데이터의 집합일 뿐입니다. 이 데이터를 유용하게 사용하기 위해 렌더링 소프트웨어와 같은 각종 프로그램이 이미 오픈소스로 나와 있습니다.

자세한 이용 방법은 [오픈스트리트맵 이용하기](https://osm.kr/usage)를 참고하세요.

[^1]: 지도 '이미지'나 오픈스트리트맵 기반 앱에는 즉각 반영되지 않을 수 있습니다.
[^2]: [지도가 열악한 차드에서 오픈스트리트맵을 활용해 백신을 빠르게 운송한 국경없는의사회](https://storymaps.arcgis.com/stories/cb81725576154ddbbdc5d7120de58a68). 2019.10.30..
[^3]: 2023년 5월 기준, 아쉽게도 국내에는 Youthmappers 지부가 없습니다. 대부분의 Youthmappers 지부는 중앙/남아프리카나 동남아시아에 주로 설치되어 있고, 동아시아 권역에서는 일본에 세 곳 존재합니다.
[^4]: [Organic Maps](https://organicmaps.app/)는 해외여행에서 많이 쓰는 오프라인 지도 앱, [Maps.me](https://maps.me/)의 한 분파(포크)입니다. 기존 Maps.me에 광고가 점점 붙고, 개인정보를 수집하기 시작하자 이 문제를 해결하기 위해 기존 Maps.me 개발팀 중 일부가 떨어져 나와 만든 것이 바로 Organic Maps입니다. Organic Maps는 Maps.me와 동일한 기능을 제공하면서 광고는 없다는 이점이 있습니다.

<!--<hr/>-->

{% include feature_row %}
