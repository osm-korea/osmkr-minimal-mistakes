---
layout: single
classes: wide
title: OpenLayers로 웹 사이트에 오픈스트리트맵 지도 띄우기
permalink: /using-osm-with-openlayers/
toc: false
toc_label: "목차"
author_profile: false
sidebar:
  nav: "sidebar"
---
**※ 아래 방법은 현재 작동하지 않습니다. 곧 내용 수정 예정입니다. ※**    
※ 이 글은 [OpenLayers 공식 홈페이지](http://openlayers.org/) 및 [Switch2OSM 웹 사이트](https://switch2osm.org/using-tiles/getting-started-with-openlayers/)에서 가져온 내용을 번역, 수정한 것입니다.

## OpenLayers란?

[OpenLayers](http://openlayers.org/)는 웹 페이지에 지도를 삽입하기 위한 완전한 자바스크립트 라이브러리입니다. OpenLayers는 BSD 오픈 소스 라이선스로 배포되므로 법적 문제 없이 모든 사이트에 OpenLayers를 넣을 수 있습니다. 소스 코드는 [깃허브](https://github.com/openlayers/ol3/)에서 볼 수 있습니다.

이 글에서는 지도를 삽입하는 간단한 방법만 소개합니다. 자세한 사용법은 공식 [자습서](http://openlayers.org/en/latest/examples/) 및 [API 문서](http://openlayers.org/en/latest/apidoc/)를 참고하세요.

## (군사 시설 없는) 한반도 지도

먼저 `openlayers.html`이라는 이름의 텍스트 파일을 만들고, 내용을 아래와 같이 입력하세요.
```html
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />

    <!-- 모바일 화면 지원 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <title>간단한 한반도 지도</title>

    <!-- OpenLayers 라이브러리 가져오기(여기서는 7.4.0을 사용했지만, 원하는 버전으로 바꿔도 무방 -->
    <!-- 실제 서비스(프로덕션) 용도로는 이 방법 대신 `npm install ol`로 직접 OpenLayers를 설치하세요. -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ol@v7.4.0/ol.css">

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
    <!-- 아래 줄은 인터넷 익스플로러나 안드로이드 4.x 버전과 같이 오래된 환경에서 OpenLayers를 구동하기 위해 필요 -->
    <script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
    <script src="https://cdn.jsdelivr.net/npm/ol@v7.4.0/dist/ol.js"></script>
  </head>
  <body>
    <div id="map" class="map"></div>
    <div id="popup" style="padding: 10px;background-color: white;"></div>
    <script>
      var map = new ol.Map({
        layers: [
          new ol.layer.Tile({
            // 일반적인 사용자 지정 타일을 삽입할 때 사용하는 코드입니다.
            // 오픈스트리트맵 공식 지도 타일을 이용할 때는 ol.source.XYZ(...) 대신
            // new ol.source.OSM()을 삽입하는 것만으로도 충분합니다.
            source: new ol.source.XYZ({
              attributions: [
              ol.source.OSM.ATTRIBUTION,
                'Tiles courtesy of ' +
                '<a href="http://openstreetmap.org">' +
                'OpenStreetMap' +
                '</a>'
              ],
              url: 'https://tiles.osm.kr/hot/{z}/{x}/{y}.png'
            })
          })
        ],
        controls: ol.control.defaults({
          // 기본 오픈스트리트맵 저작자 표기를 지도 오른쪽 아래에 표시
          attributionOptions:  {
            collapsed: false
          }
        }).extend([
          new ol.control.ScaleLine() // 축척 막대를 지도 왼쪽 하단에 노출
        ]),
        target: 'map',
        view: new ol.View({
          center: ol.proj.fromLonLat([127.766, 36.355]),
          zoom: 13
        })
      });

      // 벡터 레이어 + 지물 + 아이콘 스타일 추가
      var vectorLayer = new ol.layer.Vector({
        source: new ol.source.Vector({
          features: [
            new ol.Feature({
              geometry: new ol.geom.Point(
                ol.proj.fromLonLat([127.766, 36.355])
              ),
              name: '대한민국의 중심지, 장연리마을'
            })
          ]
        }),
        style: new ol.style.Style({
          image: new ol.style.Icon({
            anchor: [0.5, 46],
            anchorXUnits: 'fraction',
            anchorYUnits: 'pixels',
            src: 'http://openlayers.org/en/latest/examples/data/icon.png'
          })
        })
      });

      map.addLayer(vectorLayer);

      // 지도 상의 팝업을 관리하기 위한 오버레이
      var popup = document.getElementById('popup');
      var overLay = new ol.Overlay({
        element: popup,
        position: ol.proj.fromLonLat([127.766, 36.355])
      });

      map.addOverlay(overLay);

      // 지도를 클릭했을 때 팝업을 띄우고 숨기는 동작을 관리
      map.on('click', function(e) {
        var info = [];
        map.forEachFeatureAtPixel(e.pixel, function (feature) {
          info.push(feature.get('name'));
        });
        if (info.length > 0) {
          popup.innerHTML = info.join(',');
          popup.style.display = 'inline';
        } else {
          popup.innerHTML = '&nbsp;';
          popup.style.display = 'none';
        }
      });
    </script>
  </body>
</html>
```

이제 `openlayers.html`을 웹 브라우저에서 열면 아래와 같이 지도가 표시됩니다.
<br><br>

<style>
    #map_korea {
      /* 지도의 크기를 설정 */
    height: 40vh;
    }
  </style>
  <!-- 아래 줄은 인터넷 익스플로러나 안드로이드 4.x 버전과 같이 오래된 환경에서 OpenLayers를 구동하기 위해 필요 -->
  <script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
  <script src="https://cdn.jsdelivr.net/npm/ol@v7.4.0/dist/ol.js"></script>

  <div id="map_korea" class="map"></div>
  <div id="popup_korea" style="background-color: white;"></div>
  <script>
    var map = new ol.Map({
      layers: [
        new ol.layer.Tile({
          // 일반적인 사용자 지정 타일을 삽입할 때 사용하는 코드입니다.
          // 오픈스트리트맵 공식 지도 타일을 이용할 때는 ol.source.XYZ(...) 대신
          // new ol.source.OSM()을 삽입하는 것만으로도 충분합니다.
          source: new ol.source.XYZ({
            attributions: [
              ol.source.OSM.ATTRIBUTION,
              'Tiles courtesy of ' +
              '<a href="http://openstreetmap.org">' +
              'OpenStreetMap' +
              '</a>'
            ],
            url: 'https://tiles.osm.kr/hot/{z}/{x}/{y}.png'
          })
        })
      ],
      controls: ol.control.defaults({
        // 기본 오픈스트리트맵 저작자 표기를 지도 오른쪽 아래에 표시
        attributionOptions:  {
          collapsed: false
        }
      }).extend([
        new ol.control.ScaleLine() // 축척 막대를 지도 왼쪽 하단에 노출
      ]),
      target: 'map',
      view: new ol.View({
        center: ol.proj.fromLonLat([127.766, 36.355]),
        zoom: 13
      })
    });

    // 벡터 레이어 + 지물 + 아이콘 스타일 추가
    var vectorLayer = new ol.layer.Vector({
      source: new ol.source.Vector({
        features: [
          new ol.Feature({
            geometry: new ol.geom.Point(
              ol.proj.fromLonLat([127.766, 36.355])
            ),
            name: '대한민국의 중심지, 장연리마을'
          })
        ]
      }),
      style: new ol.style.Style({
        image: new ol.style.Icon({
          anchor: [0.5, 46],
          anchorXUnits: 'fraction',
          anchorYUnits: 'pixels',
          src: 'http://openlayers.org/en/latest/examples/data/icon.png'
        })
      })
    });

    map.addLayer(vectorLayer);

    // Overlay to manage popup on the top of the map
    var popup = document.getElementById('popup_korea');
    var overLay = new ol.Overlay({
      element: popup,
      position: ol.proj.fromLonLat([127.766, 36.355])
    });
    map.addOverlay(overLay);
    // 지도를 클릭했을 때 팝업을 띄우고 숨기는 동작을 관리
    map.on('click', function(e) {
      var info = [];
      map.forEachFeatureAtPixel(e.pixel, function (feature) {
        info.push(feature.get('name'));
      });
      if (info.length > 0) {
        popup.innerHTML = info.join(',');
        popup.style.display = 'inline';
      } else {
        popup.innerHTML = '&nbsp;';
        popup.style.display = 'none';
      }
    });
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
