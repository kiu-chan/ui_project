import 'package:mapbox_gl/mapbox_gl.dart';

class PointOfInterest {
  final String name;
  final LatLng location;
  final String description;
  final String imageAsset;

  PointOfInterest({required this.name, required this.location, required this.description, required this.imageAsset});
}