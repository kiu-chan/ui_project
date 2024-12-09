import 'package:latlong2/latlong.dart';

class SearchResult {
  final String title;
  final String address;
  final LatLng location;
  final String type;
  final String image;

  SearchResult({
    required this.title,
    required this.address,
    required this.location,
    required this.type,
    required this.image,
  });
}