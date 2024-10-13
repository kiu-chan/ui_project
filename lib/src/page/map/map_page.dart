import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:ui_project/src/config/map.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:ui_project/src/data/map/point.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  MapboxMapController? mapController;
  List<PointOfInterest> pointsOfInterest = [];
  final String fallbackImageAsset = 'lib/assets/market.png'; // Fallback image

  @override
  void initState() {
    super.initState();
    _fetchPointsOfInterest();
  }

  Future<void> _fetchPointsOfInterest() async {
    final firestore = FirebaseFirestore.instance;
    final pointsSnapshot = await firestore.collection('points').get();

    setState(() {
      pointsOfInterest = pointsSnapshot.docs.map((doc) {
        final data = doc.data();
        return PointOfInterest(
          name: data['name'] ?? '',
          location: LatLng(
            data['location'].latitude,
            data['location'].longitude,
          ),
          description: data['describe'] ?? '',
          imageAsset: data['imageAsset'] ?? fallbackImageAsset,
        );
      }).toList();
    });

    if (mapController != null) {
      _addPointsOfInterest();
    }
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    controller.onSymbolTapped.add(_onSymbolTapped);
    _addPointsOfInterest();
  }

  void _onStyleLoaded() {
    _addPointsOfInterest();
  }

  Future<void> _addPointsOfInterest() async {
    for (var poi in pointsOfInterest) {
      final Uint8List markerImage = await _createCustomMarkerImage(poi.imageAsset);
      await mapController?.addImage(poi.name, markerImage);
      
      await mapController?.addSymbol(
        SymbolOptions(
          geometry: poi.location,
          iconImage: poi.name,
          iconSize: 1.0,
        ),
      );
    }
  }

  Future<Uint8List> _createCustomMarkerImage(String imageSource) async {
    final double size = 120;
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint()..color = Colors.white;

    // Draw white circle as background
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2, paint);

    // Load and draw the image
    final ui.Image image = await _loadImage(imageSource);
    final imageSize = size - 20; // Slightly smaller than the background circle
    final src = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dst = Rect.fromLTWH(10, 10, imageSize, imageSize);

    // Create a circular clip path
    final clipPath = Path()
      ..addOval(Rect.fromLTWH(10, 10, imageSize, imageSize));
    canvas.clipPath(clipPath);

    // Draw the image
    canvas.drawImageRect(image, src, dst, Paint());

    // Reset the clip
    canvas.restore();
    canvas.save();

    // Draw border
    final borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2 - 2, borderPaint);

    final img = await pictureRecorder.endRecording().toImage(size.toInt(), size.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  Future<ui.Image> _loadImage(String imageSource) async {
    late Uint8List imageData;
    
    try {
      if (imageSource.startsWith('http')) {
        // Load network image
        final response = await http.get(Uri.parse(imageSource)).timeout(Duration(seconds: 5));
        if (response.statusCode == 200) {
          imageData = response.bodyBytes;
        } else {
          throw Exception('Failed to load image');
        }
      } else {
        // Load asset image
        final data = await DefaultAssetBundle.of(context).load(imageSource);
        imageData = data.buffer.asUint8List();
      }
    } catch (e) {
      print('Error loading image: $e');
      // Load fallback image
      final data = await DefaultAssetBundle.of(context).load(fallbackImageAsset);
      imageData = data.buffer.asUint8List();
    }

    final codec = await ui.instantiateImageCodec(imageData);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  void _onSymbolTapped(Symbol symbol) {
    final tappedPoi = pointsOfInterest.firstWhere(
      (poi) => poi.location == symbol.options.geometry,
      orElse: () => PointOfInterest(name: "", location: LatLng(0, 0), description: "", imageAsset: ""),
    );

    if (tappedPoi.name.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tappedPoi.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Vị trí: ${tappedPoi.location.latitude.toStringAsFixed(4)}, ${tappedPoi.location.longitude.toStringAsFixed(4)}"),
                SizedBox(height: 8),
                Text(tappedPoi.description),
              ],
            ),
          );
        },
      );
    }
  }

  void _zoomIn() {
    mapController?.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    mapController?.animateCamera(CameraUpdate.zoomOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bản đồ Du lịch Hà Nội'),
      ),
      body: Stack(
        children: [
          MapboxMap(
            accessToken: MapConfig().getMapApi(),
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoaded,
            initialCameraPosition: CameraPosition(
              target: LatLng(21.0285, 105.8522), // Tọa độ trung tâm Hà Nội
              zoom: 12.0,
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _zoomIn,
                  child: Icon(Icons.add),
                  mini: true,
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  child: Icon(Icons.remove),
                  mini: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}