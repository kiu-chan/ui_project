import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ui_project/application/map_cubit/culture_map_cubit.dart';
import 'package:ui_project/application/map_cubit/des_map_cubit.dart';
import 'package:ui_project/application/map_cubit/fes_map_cubit.dart';
import 'package:ui_project/application/map_cubit/food_map_cubit.dart';
import 'package:ui_project/data/models/Home/culture_model.dart';
import 'package:ui_project/data/models/Home/destinations_model.dart';
import 'package:ui_project/data/models/Home/festival_model.dart';
import 'package:ui_project/data/models/Home/food_model.dart';
import 'package:ui_project/presentation/widgets/map/card_map.dart';

class MapLayers extends StatelessWidget {
  final LatLng? selectedLocation;

  const MapLayers({
    Key? key,
    this.selectedLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<MapDesCubit, List<DestinationsModels>>(
          builder: (context, state) {
            return MarkerLayer(
              markers: state.map((data) {
                final isSelected = selectedLocation == data.location;
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
        BlocBuilder<FesMapCubit, List<FestivalModel>>(
          builder: (context, state) {
            return MarkerLayer(
              markers: state.map((data) {
                final isSelected = selectedLocation == data.location;
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
                final isSelected = selectedLocation == data.location;
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
                final isSelected = selectedLocation == data.location;
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
    );
  }
}