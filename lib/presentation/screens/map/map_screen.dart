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
import 'package:ui_project/data/models/Home/culture_model.dart';
import 'package:ui_project/data/models/Home/destinations_model.dart';
import 'package:ui_project/data/models/Home/festival_model.dart';
import 'package:ui_project/data/models/Home/food_model.dart';
import 'package:ui_project/data/models/Map/map_models.dart';
import 'package:ui_project/presentation/widgets/appbar_root.dart';
import 'package:ui_project/presentation/widgets/card_map.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  bool _isSearching = false;
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    context.read<MapDesCubit>().getPosition();
    context.read<FesMapCubit>().getPosition();
    context.read<CultureMapCubit>().getPosition();
    context.read<FoodMapCubit>().getPosition();
  }

  void _animateToLocation(LatLng location) {
    const double zoomLevel = 17.0; // Mức zoom chi tiết hơn

    setState(() {
      _selectedLocation = location;
    });

    // Sử dụng move của MapController thay vì animateCamera
    _mapController.move(location, zoomLevel);
  }

  void _handleSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults.clear();
      });
      return;
    }

    final List<SearchResult> results = [];
    
    // Tìm kiếm trong destinations
    final destinations = context.read<MapDesCubit>().state;
    results.addAll(destinations
        .where((dest) => dest.title.toLowerCase().contains(query.toLowerCase()) ||
            dest.address.toLowerCase().contains(query.toLowerCase()))
        .map((dest) => SearchResult(
              title: dest.title,
              address: dest.address,
              location: dest.location,
              type: 'Địa điểm du lịch',
            )));

    // Tìm kiếm trong festivals
    final festivals = context.read<FesMapCubit>().state;
    results.addAll(festivals
        .where((fest) => fest.title.toLowerCase().contains(query.toLowerCase()) ||
            fest.address.toLowerCase().contains(query.toLowerCase()))
        .map((fest) => SearchResult(
              title: fest.title,
              address: fest.address,
              location: fest.location,
              type: 'Lễ hội',
            )));

    // Tìm kiếm trong cultures
    final cultures = context.read<CultureMapCubit>().state;
    results.addAll(cultures
        .where((cult) => cult.title.toLowerCase().contains(query.toLowerCase()) ||
            cult.address.toLowerCase().contains(query.toLowerCase()))
        .map((cult) => SearchResult(
              title: cult.title,
              address: cult.address,
              location: cult.location,
              type: 'Văn hóa',
            )));

    // Tìm kiếm trong foods
    final foods = context.read<FoodMapCubit>().state;
    results.addAll(foods
        .where((food) => food.title.toLowerCase().contains(query.toLowerCase()) ||
            food.address.toLowerCase().contains(query.toLowerCase()))
        .map((food) => SearchResult(
              title: food.title,
              address: food.address,
              location: food.location,
              type: 'Ẩm thực',
            )));

    setState(() {
      _isSearching = true;
      _searchResults = results;
    });
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
                  onPositionChanged: (MapCamera position, bool hasGesture) {
                    if (state.userLocation != null) {
                      context.read<UserLocationCubit>().onMapMoved(
                            position.center != state.userLocation,
                          );
                    }
                  },
                  onTap: (tapPosition, latLng) {
                    // Ẩn kết quả tìm kiếm khi tap vào bản đồ
                    setState(() {
                      _isSearching = false;
                      _searchResults.clear();
                      _searchController.clear();
                      _selectedLocation = null;
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
                  CurrentLocationLayer(
                    turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
                    style: const LocationMarkerStyle(
                      marker: DefaultLocationMarker(),
                      markerSize: Size(20, 20),
                      markerDirection: MarkerDirection.heading,
                    ),
                  ),
                  BlocBuilder<MapDesCubit, List<DestinationsModels>>(
                    builder: (context, state) {
                      return MarkerLayer(
                        markers: state.map((data) {
                          final isSelected = _selectedLocation == data.location;
                          return Marker(
                            rotate: true,
                            width: isSelected ? 50.0 : 40.0, // Marker lớn hơn khi được chọn
                            height: isSelected ? 50.0 : 40.0,
                            point: data.location,
                            child: CardMap(
                              title: data.title,
                              location: data.location,
                              image: data.image[0],
                              address: data.address,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  BlocBuilder<FesMapCubit, List<FestivalModel>>(
                    builder: (context, state) {
                      return MarkerLayer(
                        markers: state.map((data) {
                          final isSelected = _selectedLocation == data.location;
                          return Marker(
                            rotate: true,
                            width: isSelected ? 50.0 : 40.0,
                            height: isSelected ? 50.0 : 40.0,
                            point: data.location,
                            child: CardMap(
                              title: data.title,
                              location: data.location,
                              image: data.image[0],
                              address: data.address,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  BlocBuilder<CultureMapCubit, List<CultureModel>>(
                    builder: (context, state) {
                      return MarkerLayer(
                        markers: state.map((data) {
                          final isSelected = _selectedLocation == data.location;
                          return Marker(
                            rotate: true,
                            width: isSelected ? 50.0 : 40.0,
                            height: isSelected ? 50.0 : 40.0,
                            point: data.location,
                            child: CardMap(
                              title: data.title,
                              location: data.location,
                              image: data.image[0],
                              address: data.address,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  BlocBuilder<FoodMapCubit, List<FoodModel>>(
                    builder: (context, state) {
                      return MarkerLayer(
                        markers: state.map((data) {
                          final isSelected = _selectedLocation == data.location;
                          return Marker(
                            rotate: true,
                            width: isSelected ? 50.0 : 40.0,
                            height: isSelected ? 50.0 : 40.0,
                            point: data.location,
                            child: CardMap(
                              title: data.title,
                              location: data.location,
                              image: data.image[0],
                              address: data.address,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
              // Search Bar
              Positioned(
                top: 10,
                left: 15,
                right: 15,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _handleSearch,
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm địa điểm...',
                          border: InputBorder.none,
                          icon: const Icon(Icons.search),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                      _searchResults.clear();
                                      _isSearching = false;
                                      _selectedLocation = null;
                                    });
                                  },
                                )
                              : null,
                        ),
                      ),
                    ),
                    if (_isSearching && _searchResults.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.3,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final result = _searchResults[index];
                            return ListTile(
                              title: Text(result.title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    result.type,
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(result.address),
                                ],
                              ),
                              onTap: () {
                                _animateToLocation(result.location);
                                setState(() {
                                  _isSearching = false;
                                  _searchResults.clear();
                                  _searchController.clear();
                                });
                              },
                            );
                          },
                        ),
                      ),
                  ],
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
            ],
          );
        },
      ),
    );
  }
}

class SearchResult {
  final String title;
  final String address;
  final LatLng location;
  final String type;

  SearchResult({
    required this.title,
    required this.address,
    required this.location,
    required this.type,
  });
}