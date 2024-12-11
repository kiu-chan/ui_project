import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_project/application/cultures_bloc/cultures_bloc.dart';
import 'package:ui_project/application/cultures_bloc/cultures_state.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/loading.dart';
import 'package:ui_project/presentation/widgets/card_popular.dart';

import '../../../../application/saved_cubit/saved_cultures_cubit.dart';
import '../../../../data/models/Home/culture_model.dart';
import '../../../widgets/detail.dart';

class PopularCulturesScreen extends StatelessWidget {
  const PopularCulturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCulturesBloc, PopularCultureState>(
      builder: (context, state) {
        if (state is PopularCultureLoading) {
          return const Center(
            child: AppLoading.loading,
          );
        } else if (state is PopularCultureLoaded) {
          return SizedBox(
            height: 220,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.culture.length,
                itemBuilder: (context, index) {
                  final cultures = state.culture[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              title: cultures.title,
                              image: cultures.image,
                              address: cultures.address,
                              description: cultures.description,
                              history: cultures.history,
                              feature: cultures.feature[0],
                              widget:  BlocBuilder<SavedCulturesCubit, List<CultureModel>>(
                        builder: (context, state) {
                          final isSaved =
                              state.any((item) => item.image == cultures.image);
                          return IconButton(
                            onPressed: () {
                              context
                                  .read<SavedCulturesCubit>()
                                  .toggleSave(context, cultures);
                              
                            },
                            icon: isSaved
                                ? SvgPicture.asset(AppAssets.BookMarkFill)
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
                          imageUrl: cultures.image[0],
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
                        cultures.title,
                        SvgPicture.asset(
                          AppAssets.Vn,
                          width: 20,
                          height: 20,
                        ),
                        cultures.address,
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
                            child: BlocBuilder<SavedCulturesCubit,
                                List<CultureModel>>(
                              builder: (context, state) {
                                final isSaved = state.any(
                                    (item) => item.image == cultures.image);
                                return IconButton(
                                  onPressed: () {
                                    context
                                        .read<SavedCulturesCubit>()
                                        .toggleSave(context, cultures);
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
        } else if (state is PopularCultureError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('Select a filter or load data.'));
        }
      },
    );
  }
}
