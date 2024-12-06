import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:ui_project/application/map_cubit/des_map_cubit.dart';
import 'package:ui_project/data/models/Home/destinations_model.dart';



class NearestLocationsList extends StatelessWidget {
  final LatLng userLocation;

  const NearestLocationsList({Key? key, required this.userLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapDesCubit, List<DestinationsModels>>(
      builder: (context, destinations) {
        final sortedDestinations = destinations.toList()
          ..sort((a, b) => _calculateDistance(userLocation, a.location).compareTo(_calculateDistance(userLocation, b.location)));

        final nearestDestinations = sortedDestinations.take(5).toList();

        return ListView.builder(
          shrinkWrap: true,
          itemCount: nearestDestinations.length,
          itemBuilder: (context, index) {
            final destination = nearestDestinations[index];
            final distance = _calculateDistance(userLocation, destination.location);

            return ListTile(
              leading: Image.network(destination.image[0]),
              title: Text(destination.title),
              subtitle: Text('${distance.toStringAsFixed(2)} km'),
              onTap: () {
                // Xử lý khi người dùng nhấn vào một điểm đến
              },
            );
          },
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