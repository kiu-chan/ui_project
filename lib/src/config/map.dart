import 'package:mapbox_gl/mapbox_gl.dart';

class MapConfig {
  String mapBoxApi =
      'sk.eyJ1IjoibW9ubHljdXRlIiwiYSI6ImNtMDU0bGtuZDA3d20ya3M5bmJqZ2xldWEifQ.tr24vkJc-9K5bkqM6tY_Gg';
  LatLng defaultTarget = const LatLng(21.0278, 105.8342);
  double defaultZoom = 11.0;

  String getMapApi() {
    return mapBoxApi;
  }

  LatLng getDefaultTarget() {
    return defaultTarget;
  }

  double getDefaultZoom() {
    return defaultZoom;
  }
}
