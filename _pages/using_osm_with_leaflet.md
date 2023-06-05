---
layout: single
classes: wide
title: Leaflet으로 웹 사이트에 오픈스트리트맵 지도 띄우기
permalink: /using-osm-with-leaflet/
toc: false
toc_label: "목차"
author_profile: false
sidebar:
  nav: "sidebar"
---
※ 이 글은 [Leaflet 공식 홈페이지](https://leafletjs.com/) 및 [Switch2OSM 웹 사이트](https://switch2osm.org/using-tiles/getting-started-with-leaflet/)에서 가져온 내용을 번역, 수정한 것입니다.

## Leaflet이란?

[Leaflet](http://leafletjs.com/)은 웹 페이지에 지도를 삽입하기 위한 경량 자바스크립트 라이브러리입니다. Leaflet은 BSD 오픈 소스 라이선스로 배포되므로 법적 문제 없이 모든 사이트에 Leaflet을 넣을 수 있습니다. 소스 코드는 [깃허브](http://github.com/Leaflet/Leaflet)에서 볼 수 있습니다.

이 글에서는 지도를 삽입하는 간단한 방법만 소개합니다. 자세한 사용법은 공식 [자습서](http://leafletjs.com/examples.html) 및 [문서](http://leafletjs.com/reference.html)를 참고하세요.

## (군사 시설 없는) 한반도 지도

먼저 `leaflet.html`이라는 이름의 텍스트 파일을 만들고, 내용을 아래와 같이 입력하세요.
```html
<!DOCTYPE HTML>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    
    <!-- 모바일 화면 지원 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Leaflet 라이브러리 가져오기(여기서는 1.9.4를 사용했지만, 원하는 버전으로 바꿔도 무방 -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <style>
      html, body {
        height: 100%;
        padding: 0;
        margin: 0;
      }
      #map {
        /* 지도의 크기를 설정 */
        width: 100%;
        height: 100%;
      }
    </style>
  </head>
  <body>
    
    <!-- 지도가 들어갈 자리 -->
    <div id="map"></div>
    
    <script>
      // Leaflet 초기화
      var map = L.map('map').setView({lon: 127.766, lat: 36.355}, 13);

      // 최대 범위 지정
      map.setMaxBounds([[32, 123], [44, 132.5]]);

      // '오픈스트리트맵 한국'에서 서비스하는 '군사 시설 없는 오픈스트리트맵 지도 타일'을 삽입
      L.tileLayer('https://tiles.osm.kr/hot/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap 기여자</a>'
      }).addTo(map);

      // 축척 막대를 지도 왼쪽 하단에 노출 
      L.control.scale({imperial: true, metric: true}).addTo(map);

      // 마커를 지도에 추가
      L.marker({lon: 127.766, lat: 36.355}).bindPopup('대한민국의 중심지, 장연리마을').addTo(map);
    </script>
  </body>
</html>
```

이제 `leaflet.html`을 웹 브라우저에서 열면 아래와 같이 지도가 표시됩니다.
<br><br>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<style>
    #map_korea {
    height: 40vh;
    border-style: solid;
    border-color: darkgray;
    border-width: thin;
    }
</style>
<div id="map_korea"></div>
<script>
    var map = L.map('map_korea').setView({lon: 127.766, lat: 36.355}, 13);
    map.setMaxBounds([[32, 123], [44, 132.5]]);

    L.tileLayer('https://tiles.osm.kr/hot/{z}/{x}/{y}.png', {
      minZoom: 7,
      maxZoom: 19,
      attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap 기여자</a>'
    }).addTo(map);

    L.control.scale({imperial: true, metric: true}).addTo(map);

    L.marker({lon: 127.766, lat: 36.355}).bindPopup('대한민국의 중심지, 장연리마을').addTo(map);
</script>

## 세계 지도

만약 한반도 지도가 아닌 세계지도를 띄우고 싶다면, `leaflet.html` 파일의 내용을 아래와 같이 입력하세요.

```html
<!DOCTYPE HTML>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    
    <!-- 모바일 화면 지원 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Leaflet 라이브러리 가져오기(여기서는 1.9.4를 사용했지만, 원하는 버전으로 바꿔도 무방 -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <style>
      html, body {
        height: 100%;
        padding: 0;
        margin: 0;
      }
      #map {
        /* 지도의 크기를 설정 */
        width: 100%;
        height: 100%;
      }
    </style>
  </head>
  <body>
    
    <!-- 지도가 들어갈 자리 -->
    <div id="map"></div>
    
    <script>
      // Leaflet 초기화
      var map = L.map('map').setView({lon: 0, lat: 0}, 2);

      // 오픈스트리트맵 Carto 지도 타일을 삽입
      //
      // ※ 반드시 개발 용도로만 사용할 것!
      // ※ 실제 서비스(프로덕션)용으로는 다른 지도 타일을 사용하거나 직접 타일 서버를 호스팅해야 합니다!
      L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap 기여자</a>'
      }).addTo(map);

      // 축척 막대를 지도 왼쪽 하단에 노출 
      L.control.scale({imperial: true, metric: true}).addTo(map);

      // 마커를 지도에 추가
      L.marker({lon: 0, lat: 0}).bindPopup('중심').addTo(map);
    </script>
  </body>
</html>
```

그러면 아래와 같이 세계 지도가 표시됩니다.
<br><br>

<style>
    #map_world {
    height: 40vh;
    border-style: solid;
    border-color: darkgray;
    border-width: thin;
    }
</style>
<div id="map_world"></div>
<script>
    var map = L.map('map_world').setView({lon: 0, lat: 0}, 2);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap 기여자</a>'
    }).addTo(map);

    L.control.scale({imperial: true, metric: true}).addTo(map);

    L.marker({lon: 0, lat: 0}).bindPopup('중심').addTo(map);
</script>

## 더 알아보기

* 다른 배경 지도를 넣고 싶으신가요? Leaflet은 [TMS](https://ko.wikipedia.org/wiki/%ED%83%80%EC%9D%BC_%EB%A7%B5_%EC%84%9C%EB%B9%84%EC%8A%A4)와 [WMS](https://ko.wikipedia.org/wiki/%EC%9B%B9_%EB%A7%B5_%EC%84%9C%EB%B9%84%EC%8A%A4)를 지원합니다. 자세한 설명은 [여기](http://leafletjs.com/reference.html#tilelayer)를 참고하세요.
* 마커나 선, 다각형을 추가로 넣고 싶으신가요? [GeoJSON](http://geojson.org/) 포맷으로 [삽입할 수 있습니다](http://leafletjs.com/examples/geojson.html).
* 다른 지도 투영법을 사용하고 싶으신가요? [Proj4Leaflet](https://github.com/kartena/Proj4Leaflet) 플러그인을 사용하면 됩니다.
