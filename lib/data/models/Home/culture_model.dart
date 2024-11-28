
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class CultureModel{
  List<String> image;
  String title;
  String address;
  String description;
  String history;
  List<String> feature;
  LatLng location;
  int isHot;

  CultureModel({
    required this.image,
    required this.title,
    required this.address,
    required this.description,
    required this.history,
    required this.feature,
    required this.location,
    required this.isHot,
  });

  factory CultureModel.fromJson(Map<String, dynamic> json) {
    var images = json['image'];
    List<String> imageList = [];

    if (images is String) {
      imageList = [images];
    } else if (images is List) {
      imageList = List<String>.from(images);
    }

    var features = json['feature'];
    List<String> featureList = [];

    if (features is String) {
      featureList = [features];
    } else {
      featureList = List<String>.from(features);
    }

    GeoPoint geoPoint = json['location'] ?? GeoPoint(0.0, 0.0); 

    return CultureModel(
      image: imageList,
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      history: json['history'] ?? '',
      feature: featureList,
      location: LatLng(geoPoint.latitude, geoPoint.longitude),
      isHot: json['isHot'] ?? 0,
    );
  }
}
