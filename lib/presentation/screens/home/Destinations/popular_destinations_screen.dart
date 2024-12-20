import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_project/application/destinations_bloc/destination_state.dart';
import 'package:ui_project/application/destinations_bloc/destnation_bloc.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/loading.dart';
import 'package:ui_project/presentation/widgets/card_popular.dart';
import '../../../../application/saved_cubit/saved_destinations_cubit.dart';
import '../../../../data/models/Home/destinations_model.dart';
import '../../../widgets/detail.dart';

class PopularDestinationsScreen extends StatelessWidget {
  const PopularDestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularDestnationBloc, PopularDestinationState>(
      builder: (context, state) {
        if (state is PopularDestinationLoading) {
          return const Center(
            child: AppLoading.loading,
          );
        } else if (state is PopularDestinationLoaded) {
          return SizedBox(
            height: 220,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.destination.length,
                itemBuilder: (context, index) {
                  final destination = state.destination[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              title: destination.title,
                              image: destination.image,
                              address: destination.address,
                              description: destination.description,
                              history: destination.history,
                              feature: destination.feature,
                              widget: BlocBuilder<SavedDestinationsCubit,
                                  List<DestinationsModels>>(
                                builder: (context, state) {
                                  final isSaved = state.any((item) =>
                                      item.image == destination.image);
                                  return IconButton(
                                    onPressed: () {
                                      context
                                          .read<SavedDestinationsCubit>()
                                          .toogleSave(
                                            context,
                                            destination,
                                          );
                                    },
                                    icon: isSaved
                                        ? SvgPicture.asset(
                                            AppAssets.BookMarkFill)
                                        : SvgPicture.asset(AppAssets.BookMark),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      child: cardPopular(
                        CachedNetworkImage(
                          imageUrl: destination.image[0],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            AppAssets.Marker,
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            AppAssets.Marker,
                            fit: BoxFit.cover,
                          ),
                        ),
                        destination.title,
                        SvgPicture.asset(
                          AppAssets.Vn,
                          width: 20,
                          height: 20,
                        ),
                        destination.address,
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: BlocBuilder<SavedDestinationsCubit,
                                List<DestinationsModels>>(
                              builder: (context, state) {
                                final isSaved = state.any(
                                    (item) => item.image == destination.image);
                                return IconButton(
                                  onPressed: () {
                                    context
                                        .read<SavedDestinationsCubit>()
                                        .toogleSave(
                                          context,
                                          destination,
                                        );
                                  },
                                  icon: isSaved
                                      ? SvgPicture.asset(AppAssets.BookMarkFill)
                                      : SvgPicture.asset(AppAssets.BookMark),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else if (state is PopularDestinationError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('OK'));
        }
      },
    );
  }
}
