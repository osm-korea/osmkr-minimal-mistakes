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
[네이버 지도](https://navermaps.github.io/maps.js/), [카카오맵](https://apis.map.kakao.com/), [구글 지도](https://developers.google.com/maps/gmp-get-started) 등은 원본 지도 데이터를 제공하지 않고, 대신 지도 서비스 제공사에서 제공하는 공식 API로만 지도를 이용할 수 있습니다. 그러나 오픈스트리트맵은 본질적으로 지도가 아닌 지리 공간 데이터베이스이기 때문에 직접 원본 지도 데이터를 다운로드할 수 있습니다.

원본 지도 데이터가 필요하지 않고, 단순히 지도 이미지만 필요하다면 [웹 사이트 및 앱에 지도 이미지 및 마커 표시하기](https://osm.kr/usage/#%EC%9B%B9-%EC%82%AC%EC%9D%B4%ED%8A%B8-%EB%B0%8F-%EC%95%B1%EC%97%90-%EC%A7%80%EB%8F%84-%EC%9D%B4%EB%AF%B8%EC%A7%80-%EB%B0%8F-%EB%A7%88%EC%BB%A4-%ED%91%9C%EC%8B%9C%ED%95%98%EA%B8%B0) 단락을 참고하세요.

## 웹 사이트 및 앱에 지도 이미지 및 마커 표시하기
지도 이미지를 표시하려면 지도 타일(이미지)을 생성하는 소프트웨어와 생성된 지도 타일을 프론트엔드로 뿌려 주는 라이브러리가 필요합니다. 개발 과정에서는 tile.openstreetmap.org[^1]에서 만들어 주는 지도 타일을 갖다 써도 괜찮지만, 실제 배포(프로덕션) 단계에서는 반드시 직접 지도 타일 서버를 구축하거나 제3자 서비스를 이용해야 합니다. 오픈스트리트맵 공식 서버는 기부로 운영되기 때문에 상업 운용 중에 발생하는 대량의 트래픽을 감당하기 힘듭니다. 자세한 정보는 오픈스트리트맵 재단의 [타일 사용 정책(Tile Usage Policy)](https://operations.osmfoundation.org/policies/tiles/)(영어)을 참고하세요.

### 지도 타일 생성하기
지도 타일을 생성하려면 [PostgreSQL](http://www.postgresql.org/), [PostGIS](http://postgis.net/), mod_tile([깃허브](https://github.com/openstreetmap/mod_tile)), [mapnik](https://mapnik.org/), [Apache2](https://httpd.apache.org/), [osm2pgsql](https://osm2pgsql.org/) 등이 필요합니다.    
자세한 설치 방법은 [오픈스트리트맵 지도 타일 서버 호스팅하기(우분투 22.04 기준)](https://osm.kr/hosting-map-tile-ubuntu2204/)를 참고하세요. [도커를 이용해](https://osm.kr/using-a-docker-container/) 손쉽게 타일 서버를 구축할 수도 있습니다.


### 지도 타일 표시하기
* [Leaflet](https://leafletjs.com/): TMS(Tiled Map Service) 지도 타일(이미지), GeoJSON을 비롯한 다양한 형태의 지리 정보를 웹 사이트에 삽입할 수 있는 자바스크립트 라이브러리입니다. 오픈스트리트맵 세계에서 가장 많이 사용됩니다. 오픈스트리트맵뿐만 아니라 구글 지도, 네이버 지도 등에도 활용할 수 있는 다재다능한 라이브러리입니다.
    * 자세한 사용법은 [Leaflet으로 웹 사이트에 오픈스트리트맵 지도 띄우기](https://osm.kr/using-osm-with-leaflet/)를 참고하세요.


* [OpenLayers](https://openlayers.org/): Leaflat보다 강력한 자바스크립트 라이브러리입니다. Leaflat에서는 플러그인을 깔아야 지원되는 GeoJSON, GeoRSS, KML, GML, OGC 포맷을 기본적으로 지원하며, WebGL로 그래픽 가속 또한 가능합니다.
    * 자세한 사용법은 [Switch2OSM](https://switch2osm.org/using-tiles/getting-started-with-openlayers/)(영어)을 참고하세요.

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

이 외에도 다양한 오픈스트리트맵 관련 소프트웨어가 있습니다. 오픈스트리트맵 위키의 [소프트웨어 라이브러리](https://wiki.openstreetmap.org/wiki/Software_libraries)(영어) 문서를 참고하세요. 다양한 오픈소스 지리공간 정보 소프트웨어를 지원하는 [OSGeo](http://www.osgeo.org/)([한국어 지부](https://www.osgeo.kr/))에서 더 많은 정보를 얻을 수 있습니다.

## 지도 편집 API
오픈스트리트맵은 누구나 편집할 수 있는 지도입니다. 모든 오픈스트리트맵 편집기는 근본적으로 [API v0.6](https://wiki.openstreetmap.org/wiki/Ko:API_v0.6)이라는 **지도 편집용** API를 통해 오픈스트리트맵 공식 서버와 통신합니다.

API v0.6은 여타 지도 API와 다르게 지도 이용이 아닌 편집에 초점이 맞춰져 있기 때문에 사용하기 무척 어렵습니다. 다행히도 오픈스트리트맵 편집기를 바닥부터 짜올리지 않는 이상 단순히 지도 데이터를 이용하거나 편집하는 데 이 API v0.6을 직접적으로 이용할 일은 없습니다.

※ 지도 편집 API는 오픈스트리트맵 재단에서 [기부금](https://donate.openstreetmap.org/)으로 운영합니다. **지도 편집 외의 목적**으로 과도하게 이용할 경우 ip가 차단될 수 있습니다.

## 지도 데이터 읽기 API
앞서 언급했듯이 지도 편집용 API v0.6으로는 지도 데이터를 대량으로 가져올 수 없습니다. 편집 없이 단순히 오픈스트리트맵 데이터를 얻으려면 읽기 전용 API, [Overpass API](http://overpass-api.de/)([위키](https://wiki.openstreetmap.org/wiki/Overpass_API))를 이용하면 됩니다. 오픈스트리트맵 재단에서 공식적으로 운영하는 Overpass API 서버는 없지만, 서버 상태나 접속 상태, 이용 한도에 따라 적절한 공개 Overpass API 서버를 골라서 이용하면 됩니다. 물론 원한다면 직접 Overpass API 인스턴스를 하나 만들 수도 있습니다.

다만 Overpass API는 사용하기 복잡하기 때문에 보다 쉬운 문법으로 Overpass API를 호출할 수 있는 일종의 프론트엔드, [Overpass Turbo](https://overpass-turbo.eu/)([위키](https://wiki.openstreetmap.org/wiki/Overpass_turbo))를 이용하는 것을 추천합니다.

Overpass API와 Overpass Turbo를 적절히 이용하면 특정 지역의 모든 오픈스트리트맵 데이터를 가져올 수도 있고, 특정 조건에 맞는 데이터만 가져올 수도 있습니다. 자세한 사용법은 위키 문서를 참고하세요.

※ 개발 중인 서비스나 소규모 상업 서비스에는 공개 Overpass API 서버를 이용해도 큰 문제는 없습니다. 그러나 하루에 수만 명 이상이 이용하는 대규모 서비스를 운영하려 한다면 [직접 Overpass API 인스턴스를 구축](https://dev.overpass-api.de/overpass-doc/en/more_info/setup.html)해 주세요.

## 원본 지도 데이터 다운로드하기
### Planet OSM
오픈스트리트맵 공식 홈페이지에서는 매주 전 세계의 오픈스트리트맵 데이터가 담긴 XML 압축 파일과 [PBF 파일](https://wiki.openstreetmap.org/wiki/PBF_Format)을 업로드합니다. 2023년 8월 9일 기준으로 XML 압축 파일의 크기는 129 GB, PBF 파일의 크기는 70 GB입니다. 앞서 언급했듯이 이렇게 큰 용량의 파일을 직접 다운로드하면 공식 서버에 큰 무리를 주기 때문에 가급적이면 토렌트나 [미러](https://wiki.openstreetmap.org/wiki/Planet.osm#Planet.osm_mirrors)를 이용해 주세요.

### Geofabrik
Planet OSM은 전 세계 단위의 데이터만 제공합니다. 그렇다면 한국의 지도 데이터만 얻고 싶을 때는 몇십 GB나 되는 Planet OSM 파일을 다운로드한 다음에 한국 지역 데이터만 거르는 방법을 써야 하는 걸까요? 다행히 그렇지 않습니다.

독일의 지리 공간 기업, [Geofabrik](https://www.geofabrik.de/)에서는 매일 모든 국가 및 지역의 오픈스트리트맵 데이터를 잘라서 [download.geofabrik.de](https://download.geofabrik.de/)에 업로드합니다. 대한민국 전역의 오픈스트리트맵 데이터는 [download.geofabrik.de/asia/south-korea.html](https://download.geofabrik.de/asia/south-korea.html)에서 다운로드할 수 있습니다. 2023년 8월 9일 기준으로 대한민국 전역의 PBF 파일은 178 MB입니다. Planet OSM 파일의 70 GB와 비교하면 확연히 적은 크기이죠.

※ 오픈스트리트맵 기여자들의 개인정보가 포함되어 있는 데이터 파일이나 역사 파일(.osh.pbf)은 유럽 연합의 데이터 보호 규정에 의해 오픈스트리트맵 계정이 있는 사람만 다운로드할 수 있으며, 해당 파일을 기반으로 한 작업물은 오픈스트리트맵 기여자만 볼 수 있도록 조치를 취해야 합니다.

## 원본 오픈스트리트맵 데이터 조작하기
전 세계의 지리공간 정보를 날것 그대로 보고, 원하는 대로 조작하고, 복잡한 저작권 문제 없이 (**'ⓒOpenStreetMap 기여자'**만 적어서) 배포하는 것은 오픈스트리트맵만의 특권입니다.

* [Osmosis](http://wiki.openstreetmap.org/wiki/Osmosis): 오픈스트리트맵 데이터를 조작하는 Java 프로그램입니다. 기능이 매우 강력합니다.
* [Osmium](http://wiki.openstreetmap.org/wiki/Osmium): Osmosis보다 가볍고 유연합니다.
* [QGIS](https://qgis.org/ko/site/): QGIS는 범용 지리 정보 분석 프로그램이지만, 오픈스트리트맵 데이터를 조작하고, 변경 내역을 업로드하는 용도로도 사용할 수 있습니다. QGIS 3.0부터 오픈스트리트맵 래스터/벡터 레이어를 별도의 플러그인 없이 기본적으로 지원합니다.
* [ArcGIS](http://www.arcgis.com/): [ArcGIS Editor for OSM](https://github.com/Esri/arcgis-osm-editor) 플러그인을 설치하면 ArcGIS에서도 오픈스트리트맵을 편집할 수 있습니다.
* [PostGIS](http://postgis.net/): [PostgreSQL](http://www.postgresql.org/)의 확장 프로그램입니다. 관계형 데이터베이스에 지리공간 정보를 효율적으로 저장하고 조작할 수 있도록 해 줍니다.

## 타사 서비스 이용하기
리눅스와 각종 오픈소스 애플리케이션을 만져 가면서 직접 서비스를 구축하는 일은 숙련되지 않은 개발자, 혹은 비개발자에게는 어렵고 부담스러운 일입니다. 이럴 때는 오픈스트리트맵 데이터를 활용해 지도 서비스를 제공하는 기업을 이용할 수 있습니다. 직접 지리 정보를 구축하고 관리하지 않기 때문에 구글 지도보다 가격이 싸다는 장점이 있습니다.

* [맵박스(Mapbox)](https://www.mapbox.com/)
* [맵타일러(Maptiler)](https://www.maptiler.com/)
* [Geofabrik](https://www.geofabrik.de/)
* [OpenCage](https://opencagedata.com/)

※ 위의 정보는 [Switch2OSM](https://switch2osm.org/)에서 가져왔습니다.    
※ 오픈스트리트맵을 유용하게 사용하고 계시다면 [기부](https://supporting.openstreetmap.org/)나 [지도 편집](https://learnosm.org/ko/beginner/start-osm/)으로 오픈스트리트맵 생태계를 지원해 주세요.

[^1]: \[ a \| b \| c \].tile.openstreetmap.org 및 \[ a \| b \| c \].tile.osm.org, tile.osm.org URL은 미래에 [지원 종료됩니다](https://github.com/openstreetmap/operations/issues/737). 만약 해당 URL을 사용하고 계시다면 tile.openstreetmap.org로 전환해 주세요. http 연결 또한 지원 종료됩니다.
