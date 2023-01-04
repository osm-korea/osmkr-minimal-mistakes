---
title: "오픈스트리트맵 이용하기"
layout: splash
permalink: /usage/
read_time: false
date: 2023-01-04T01:04:11+09:00
header:
  overlay_color: "#000"
  overlay_filter: "0.3 "
  overlay_image: /assets/image/about_image.png
  caption: "Photo credit: [**OpenStreetMap Contributors**](https://osm.org)"
excerpt: "전 세계의 지리공간 정보를 날것 그대로 보고, 원하는 대로 조작하고, 복잡한 저작권 문제 없이 (**'ⓒOpenStreetMap 기여자'**만 적어서) 배포하는 것은 오픈스트리트맵만의 특권입니다."
---
[네이버 지도](https://navermaps.github.io/maps.js/), [카카오맵](https://apis.map.kakao.com/), [구글 지도](https://developers.google.com/maps/gmp-get-started) 등은 지도 서비스 제공사에서 직접 공식 API를 제공합니다. 그러나 오픈스트리트맵은 본질적으로 지도가 아닌 지리 공간 데이터베이스라서 지도를 이용하는 공식 API가 없습니다(오픈스트리트맵 위키에 있는 [API v0.6](https://wiki.openstreetmap.org/wiki/Ko:API_v0.6)은 **지도 편집용** API입니다. 물론 이 API로 지도 데이터를 대량으로 가져올 수는 있지만, 이렇게 하면 기부금으로 운영되는 오픈스트리트맵 공식 서버에 큰 무리를 줍니다).

그렇다면 API를 직접 만들어 써야 하는 것인가 하면 그렇지 않습니다. 오픈스트리트맵은 오픈소스에 친화적이기 때문에 다양한 오픈소스 프로그램 및 API를 활용할 수 있습니다.

## 웹 사이트 및 앱에 지도 이미지 및 마커 표시하기
지도 이미지를 표시하려면 지도 타일(이미지)을 생성하는 소프트웨어와 생성된 지도 타일을 프론트엔드로 뿌려 주는 라이브러리가 필요합니다. 개발 과정에서는 tile.openstreetmap.org[^1]에서 만들어 주는 지도 타일을 갖다 써도 괜찮지만, 실제 배포(프로덕션) 단계에서는 반드시 직접 지도 타일 서버를 구축하거나 제3자 서비스를 이용해야 합니다. 오픈스트리트맵 공식 서버는 기부로 운영되기 때문에 상업 운용 중에 발생하는 대량의 트래픽을 감당하기 힘듭니다. 자세한 정보는 오픈스트리트맵 재단의 [타일 사용 정책(Tile Usage Policy)](https://operations.osmfoundation.org/policies/tiles/)(영어)을 참고하세요.

### 지도 타일 생성하기
지도 타일을 생성하려면 [PostgreSQL](http://www.postgresql.org/), [PostGIS](http://postgis.net/), mod_tile([깃허브](https://github.com/openstreetmap/mod_tile)), [mapnik](https://mapnik.org/), [Apache2](https://httpd.apache.org/), [osm2pgsql](https://osm2pgsql.org/) 등이 필요합니다. 자세한 설치 방법은 [Switch2OSM](https://switch2osm.org/serving-tiles/)(영어)을 참고하세요. [도커를 이용해](https://switch2osm.org/serving-tiles/using-a-docker-container/) 손쉽게 타일 서버를 구축할 수도 있습니다.


### 지도 타일 표시하기
* [Leaflet](https://leafletjs.com/): TMS(Tiled Map Service) 지도 타일(이미지), GeoJSON을 비롯한 다양한 형태의 지리 정보를 웹 사이트에 삽입할 수 있는 자바스크립트 라이브러리입니다. 오픈스트리트맵 세계에서 가장 많이 사용됩니다. 오픈스트리트맵뿐만 아니라 구글 지도, 네이버 지도 등에도 활용할 수 있는 다재다능한 라이브러리입니다.<br>
[Switch2OSM](https://switch2osm.org/using-tiles/getting-started-with-leaflet/)(영어)에서 사용법을 자세히 볼 수 있습니다.
* [OpenLayers](https://openlayers.org/): Leaflat보다 강력한 자바스크립트 라이브러리입니다. Leaflat에서는 플러그인을 깔아야 지원되는 GeoJSON, GeoRSS, KML, GML, OGC 포맷을 기본적으로 지원하며, WebGL로 그래픽 가속 또한 가능합니다.<br>
[Switch2OSM](https://switch2osm.org/using-tiles/getting-started-with-openlayers/)(영어)에서 사용법을 자세히 볼 수 있습니다.

단순히 동적 지도를 웹 사이트에 띄울 목적이면 Leaflat이 적합하고, 다른 GIS 소프트웨어에 지도를 통합해 강력한 기능을 구축하려면 OpenLayers가 적합합니다.

## 모바일에서 벡터 지도 표시하기
* [MapLibre Android SDK](https://maplibre.org/projects/maplibre-native/), [Mapbox Android SDK](https://www.mapbox.com/android-sdk/), [mapsforge](http://mapsforge.org/), [Skobbler Android SDK](http://developer.skobbler.com/): 안드로이드 운영체제에서 벡터 지도를 띄울 수 있는 라이브러리입니다.
* [MapLibre iOS SDK](https://maplibre.org/projects/maplibre-native/), [Mapbox iOS SDK](https://www.mapbox.com/ios-sdk/), [Skobbler iOS SDK](http://developer.skobbler.com/): iOS 운영체제에서 벡터 지도를 띄울 수 있는 라이브러리입니다.
* [Nutiteq Maps SDK](https://developer.nutiteq.com/), [Tangram ES](https://github.com/tangrams/tangram-es/): 안드로이드/iOS 크로스 플랫폼을 지원하는 벡터 지도 라이브러리입니다.

## 웹에서 벡터 지도 표시하기
* [MapLibre GL JS](https://maplibre.org/projects/maplibre-gl-js/), [Mapbox GL JS](https://www.mapbox.com/mapbox-gl-js/), [Tangram](http://tangrams.github.io/tangram/): 웹에서 벡터 지도 타일을 렌더링하는 라이브러리입니다. WebGL 가속을 지원합니다.

## 경로 탐색(내비게이션) 삽입하기
* [OSRM](http://project-osrm.org/): 자동차, 자전거, 도보 경로 탐색을 지원하는 HTTP 서버 및 C++ 라이브러리입니다. 오픈스트리트맵 데이터용으로 설계되었습니다.
* [Graphhopper](https://github.com/graphhopper/graphhopper/): 메모리 사용량이 적은 Java 경로 탐색 엔진입니다. 마찬가지로 자동차, 자전거, 도보 경로 탐색을 지원합니다.
* [Valhalla](https://valhalla.readthedocs.io/en/latest/): 자동차, 자전거, 도보뿐만 아니라 대중교통 경로 탐색까지 지원하는 C++ 경로 탐색 엔진입니다.
* [Openrouteservice](https://openrouteservice.org/): 경로 탐색 기능뿐만 아니라 등시선(isochrome), 시간-거리 행렬을 활용한 다대다 경로 탐색, 특정 위치 부근의 관심 지점(POI) 찾기 등을 지원하는 다용도 API입니다.

## 장소명으로 위치를 찾는 지오코딩(Geocoding) 서비스 구축하기
* [Photon](https://github.com/komoot/photon): Java로 제작되었습니다. 한국어 검색 성능이 노미나팀보다 좋습니다.
* [노미나팀(Nominatim)](https://nominatim.org/): 파이썬과 PHP로 제작되었습니다. 오픈스트리트맵 홈페이지의 검색 엔진이 노미나팀을 사용합니다. 로마자 외의 문자 지원이 좋지 않다는 단점이 있습니다.

## 원본 오픈스트리트맵 데이터 조작하기
전 세계의 지리공간 정보를 날것 그대로 보고, 원하는 대로 조작하고, 복잡한 저작권 문제 없이 (**'ⓒOpenStreetMap 기여자'**만 적어서) 배포하는 것은 오픈스트리트맵만의 특권입니다.

* [Overpass API](http://overpass-api.de/): 다양한 조건으로 오픈스트리트맵 데이터를 가져올 수 있는 읽기 전용 API입니다. 오픈스트리트맵 공식 서버의 트래픽을 줄이기 위해 편집 목적이 아닌 데이터 다운로드는 Overpass API 서버를 이용해 주세요. 무료로 이용할 수 있는 서버 목록은 [오픈스트리트맵 위키 Overpass API 문서](https://wiki.openstreetmap.org/wiki/Overpass_API)의 'Public Overpass API instances' 단락을 확인하세요. 직접 Overpass API 서버를 구축할 수도 있습니다. [Overpass Turbo](https://overpass-turbo.eu/)에서 Overpass API를 쉽게 이용할 수 있습니다.
* [Osmosis](http://wiki.openstreetmap.org/wiki/Osmosis): 오픈스트리트맵 데이터를 조작하는 Java 프로그램입니다. 기능이 매우 강력합니다.
* [Osmium](http://wiki.openstreetmap.org/wiki/Osmium): Osmosis보다 가볍고 유연합니다.
* [QGIS](https://qgis.org/ko/site/): QGIS는 범용 지리 정보 분석 프로그램이지만, 오픈스트리트맵 데이터를 조작하고, 변경 내역을 업로드하는 용도로도 사용할 수 있습니다. QGIS 3.0부터 오픈스트리트맵 래스터/벡터 레이어를 별도의 플러그인 없이 기본적으로 지원합니다.
* [ArcGIS](http://www.arcgis.com/): [ArcGIS Editor for OSM](https://github.com/Esri/arcgis-osm-editor) 플러그인을 설치하면 ArcGIS에서도 오픈스트리트맵을 편집할 수 있습니다.
* [PostGIS](http://postgis.net/): [PostgreSQL](http://www.postgresql.org/)의 확장 프로그램입니다. 관계형 데이터베이스에 지리공간 정보를 효율적으로 저장하고 조작할 수 있도록 해 줍니다.

이 외에도 다양한 오픈스트리트맵 관련 소프트웨어가 있습니다. 오픈스트리트맵 위키의 [소프트웨어 라이브러리](https://wiki.openstreetmap.org/wiki/Software_libraries)(영어) 문서를 참고하세요. 다양한 오픈소스 지리공간 정보 소프트웨어를 지원하는 [OSGeo](http://www.osgeo.org/)([한국어 지부](https://www.osgeo.kr/))에서 더 많은 정보를 얻을 수 있습니다.

## 타사 서비스 이용하기
리눅스와 각종 오픈소스 애플리케이션을 만져 가면서 직접 서비스를 구축하는 일은 숙련되지 않은 개발자, 혹은 비개발자에게는 어렵고 부담스러운 일입니다. 이럴 때는 오픈스트리트맵 데이터를 활용해 지도 서비스를 제공하는 기업을 이용할 수 있습니다. 직접 지리 정보를 구축하고 관리하지 않기 때문에 구글 지도보다 가격이 싸다는 장점이 있습니다.

* [맵박스(Mapbox)](https://www.mapbox.com/)
* [맵타일러(Maptiler)](https://www.maptiler.com/)
* [Geofabrik](https://www.geofabrik.de/)
* [OpenCage](https://opencagedata.com/)

※ 위의 정보는 [Switch2OSM](https://switch2osm.org/)에서 가져왔습니다.

[^1]: \[ a \| b \| c \].tile.openstreetmap.org 및 \[ a \| b \| c \].tile.osm.org, tile.osm.org URL은 미래에 [지원 종료됩니다](https://github.com/openstreetmap/operations/issues/737). 만약 해당 URL을 사용하고 계시다면 tile.openstreetmap.org로 전환해 주세요. http 연결 또한 지원 종료됩니다.
