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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/textStyle.dart';

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
    
    // Search in destinations
    final destinations = context.read<MapDesCubit>().state;
    results.addAll(destinations
        .where((dest) => dest.title.toLowerCase().contains(query.toLowerCase()) ||
            dest.address.toLowerCase().contains(query.toLowerCase()))
        .map((dest) => SearchResult(
              title: dest.title,
              address: dest.address,
              location: dest.location,
              type: 'Địa điểm du lịch',
              image: dest.image[0],
            )));

    // Search in festivals
    final festivals = context.read<FesMapCubit>().state;
    results.addAll(festivals
        .where((fest) => fest.title.toLowerCase().contains(query.toLowerCase()) ||
            fest.address.toLowerCase().contains(query.toLowerCase()))
        .map((fest) => SearchResult(
              title: fest.title,
              address: fest.address,
              location: fest.location,
              type: 'Lễ hội',
              image: fest.image[0],
            )));

    // Search in cultures
    final cultures = context.read<CultureMapCubit>().state;
    results.addAll(cultures
        .where((cult) => cult.title.toLowerCase().contains(query.toLowerCase()) ||
            cult.address.toLowerCase().contains(query.toLowerCase()))
        .map((cult) => SearchResult(
              title: cult.title,
              address: cult.address,
              location: cult.location,
              type: 'Văn hóa',
              image: cult.image[0],
            )));

    // Search in foods
    final foods = context.read<FoodMapCubit>().state;
    results.addAll(foods
        .where((food) => food.title.toLowerCase().contains(query.toLowerCase()) ||
            food.address.toLowerCase().contains(query.toLowerCase()))
        .map((food) => SearchResult(
              title: food.title,
              address: food.address,
              location: food.location,
              type: 'Ẩm thực',
              image: food.image[0],
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
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: result.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Image.asset(
                        AppAssets.Marker,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        AppAssets.Marker,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    result.title,
                    style: AppTextStyle.headLineStyle,
                  ),
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
                      Text(
                        result.address,
                        style: AppTextStyle.bodyStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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