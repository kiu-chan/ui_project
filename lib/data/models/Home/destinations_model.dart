import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class DestinationsModels {
  final List<String> image;
  final String title;
  final String address;
  final String content;
  final String description;
  final String history;
  final String feature;
  final LatLng location;
  final int isHot;

  DestinationsModels({
    required this.image,
    required this.title,
    required this.address,
    required this.content,
    required this.description,
    required this.history,
    required this.feature,
    required this.location,
    required this.isHot,
  });

  factory DestinationsModels.fromJson(Map<String, dynamic> json) {
    var images = json['image'];
    List<String> imageList = [];

    if (images is String) {
      imageList = [images];
    } else if (images is List) {
      imageList = List<String>.from(images);
    }

    GeoPoint geoPoint = json['location'] ?? GeoPoint(0.0, 0.0);

    return DestinationsModels(
      image: imageList,
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      content: json['content'] ?? '',
      description: json['description'] ?? '',
      history: json['history'] ?? '',
      feature: json['feature'] ?? '',
      location: LatLng(geoPoint.latitude, geoPoint.longitude), 
      isHot: json['isHot'] ?? 0,
    );
  }
}
