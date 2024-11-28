
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class FestivalModel {
  List<String> image;
  String title;
  String address;
  String time;
  String description;
  String history;
  String feature;
  LatLng location;
  int isHot;

  FestivalModel({
    required this.image,
    required this.title,
    required this.address,
    required this.time,
    required this.description,
    required this.history,
    required this.feature,
    required this.location,
    required this.isHot,
  });

  factory FestivalModel.fromJson(Map<String, dynamic> json) {
    var images = json['image'];
    List<String> imageList = [];

    if (images is String) {
      imageList = [images];
    } else if (images is List) {
      imageList = List<String>.from(images);
    }

    GeoPoint geoPoint = json['location'] ?? GeoPoint(0.0, 0.0);

    return FestivalModel(
      image: imageList,
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      time: json['time'] ?? '',
      description: json['description'] ?? '',
      history: json['history'] ?? '',
      feature: json['feature'] ?? '',
      location: LatLng(geoPoint.latitude, geoPoint.longitude),
      isHot: json['isHot'] ?? 0,
    );
  }
}
