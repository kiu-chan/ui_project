import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ui_project/application/map_cubit/culture_map_cubit.dart';
import 'package:ui_project/application/map_cubit/des_map_cubit.dart';
import 'package:ui_project/application/map_cubit/fes_map_cubit.dart';
import 'package:ui_project/application/map_cubit/food_map_cubit.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/presentation/screens/map/search_result.dart';

class MapSearchBar extends StatefulWidget {
  final MapController mapController;
  final Function(LatLng?) onLocationSelected;

  const MapSearchBar({
    Key? key,
    required this.mapController,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  State<MapSearchBar> createState() => _MapSearchBarState();
}

class _MapSearchBarState extends State<MapSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  bool _isSearching = false;

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

  void _animateToLocation(LatLng location) {
    const double zoomLevel = 17.0;
    widget.mapController.move(location, zoomLevel);
    widget.onLocationSelected(location);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          widget.onLocationSelected(null);
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
    );
  }
}