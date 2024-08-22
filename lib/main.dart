import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapbox Flutter Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  MapboxMapController? mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapbox Flutter Demo'),
      ),
      body: MapboxMap(
        accessToken:
            'sk.eyJ1IjoibW9ubHljdXRlIiwiYSI6ImNtMDU0bGtuZDA3d20ya3M5bmJqZ2xldWEifQ.tr24vkJc-9K5bkqM6tY_Gg',
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(21.0278, 105.8342),
          zoom: 11.0,
        ),
      ),
    );
  }
}