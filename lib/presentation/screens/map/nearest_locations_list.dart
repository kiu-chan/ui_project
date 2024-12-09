import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ui_project/application/map_cubit/des_map_cubit.dart';
import 'package:ui_project/data/models/Home/destinations_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:ui_project/core/constant/color.dart';

class NearestLocationsList extends StatelessWidget {
  final LatLng userLocation;
  final MapController mapController;
  final Function(LatLng) onLocationSelected;

  const NearestLocationsList({
    Key? key,
    required this.userLocation,
    required this.mapController,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapDesCubit, List<DestinationsModels>>(
      builder: (context, destinations) {
        final sortedDestinations = destinations.toList()
          ..sort((a, b) => _calculateDistance(userLocation, a.location)
              .compareTo(_calculateDistance(userLocation, b.location)));

        final nearestDestinations = sortedDestinations.take(5).toList();

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thêm thanh kéo
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Thông tin mới nhất tại vị trí hiện tại của bạn',
                  style: AppTextStyle.headLineStyle,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: nearestDestinations.length,
                  itemBuilder: (context, index) {
                    final destination = nearestDestinations[index];
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            destination.title,
                            style: AppTextStyle.headLineStyle.copyWith(
                              fontSize: 18,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            mapController.move(destination.location, 17);
                            onLocationSelected(destination.location);
                          },
                          child: Container(
                            height: 200, // Tăng chiều cao của card
                            margin: const EdgeInsets.only(bottom: 20), // Tăng khoảng cách giữa các card
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: destination.image[0],
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
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                            imageUrl: destination.image.length > 1 
                                                ? destination.image[1] 
                                                : destination.image[0],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
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
                                      ),
                                      const SizedBox(height: 8),
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                            imageUrl: destination.image.length > 2 
                                                ? destination.image[2] 
                                                : destination.image[0],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
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
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _calculateDistance(LatLng point1, LatLng point2) {
    const earthRadius = 6371;
    final lat1 = point1.latitude;
    final lon1 = point1.longitude;
    final lat2 = point2.latitude;
    final lon2 = point2.longitude;

    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }
}