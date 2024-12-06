import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/application/map_cubit/culture_map_cubit.dart';
import 'package:ui_project/application/map_cubit/des_map_cubit.dart';
import 'package:ui_project/application/map_cubit/fes_map_cubit.dart';
import 'package:ui_project/application/map_cubit/food_map_cubit.dart';
import 'package:ui_project/application/map_cubit/map_cubit.dart';
import 'package:ui_project/core/config/map_config.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/data/models/Map/map_models.dart';
import 'package:ui_project/presentation/screens/map/map_layers.dart';
import 'package:ui_project/presentation/screens/map/nearest_locations_list.dart';
import 'package:ui_project/presentation/screens/map/search_bar.dart';
import 'package:ui_project/presentation/widgets/appbar_root.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? _selectedLocation;
  bool _showNearestLocations = false;

  @override
  void initState() {
    super.initState();
    context.read<MapDesCubit>().getPosition();
    context.read<FesMapCubit>().getPosition();
    context.read<CultureMapCubit>().getPosition();
    context.read<FoodMapCubit>().getPosition();
  }

  @override
  Widget build(BuildContext context) {
    final mapConfig = MapConfig();

    return Scaffold(
      appBar: AppbarRoot(
        title: 'Bản đồ',
      ),
      body: BlocBuilder<UserLocationCubit, MapState>(
        builder: (context, state) {
          final LatLng initialCenter =
              state.userLocation ?? const LatLng(21.0368973, 105.8320918);

          final bool isMapMoved = state.isMapMoved;

          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: initialCenter,
                  initialZoom: 15,
                  onPositionChanged: (position, bool? hasGesture) {
                    if (state.userLocation != null) {
                      context.read<UserLocationCubit>().onMapMoved(
                            position.center != state.userLocation,
                          );
                    }
                  },
                  onTap: (tapPosition, LatLng latLng) {
                    setState(() {
                      _selectedLocation = null;
                      _showNearestLocations = false;
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                    additionalOptions: {
                      'accessToken': mapConfig.MapApi,
                      'id': 'mapbox/streets-v12',
                    },
                  ),
                  CurrentLocationLayer(),
                  MapLayers(selectedLocation: _selectedLocation),
                ],
              ),
              // Search Bar
              Positioned(
                top: 10,
                left: 15,
                right: 15,
                child: MapSearchBar(
                  mapController: _mapController,
                  onLocationSelected: (location) {
                    setState(() {
                      _selectedLocation = location;
                      _showNearestLocations = false;
                    });
                  },
                ),
              ),
              // Location Button
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.1,
                right: 15,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                  onPressed: () {
                    if (state.userLocation != null) {
                      _mapController.move(state.userLocation!, 15);
                      setState(() {
                        _selectedLocation = null;
                        _showNearestLocations = true;
                      });
                    }
                  },
                  child: Icon(
                    isMapMoved ? LucideIcons.locate : LucideIcons.locateFixed,
                    color: isMapMoved ? Colors.black87 : AppColors.primaryColor,
                    size: 25,
                  ),
                ),
              ),
              // Nearest Locations List
              if (_showNearestLocations && state.userLocation != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Colors.white,
                    child: NearestLocationsList(userLocation: state.userLocation!),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}