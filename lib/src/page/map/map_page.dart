import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:ui_project/src/config/map.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
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
        accessToken: MapConfig().getMapApi(),
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: MapConfig().getDefaultTarget(),
          zoom: MapConfig().defaultZoom,
        ),
      ),
    );
  }
}
