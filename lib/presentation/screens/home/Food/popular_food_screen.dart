import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_project/application/popular_foods_bloc/popular_food_bloc.dart';
import 'package:ui_project/application/popular_foods_bloc/popular_food_state.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/loading.dart';
import 'package:ui_project/presentation/widgets/card_popular.dart';

class PopularFoodScreen extends StatelessWidget {
  const PopularFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularFoodBloc, PopularFoodState>(
        builder: (context, state) {
          if (state is PopularFoodLoading) {
            return Center(
              child: AppLoading.loading,
            );
          } else if (state is PopularFoodLoaded) {
            return SizedBox(
              height: 220,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.food.length,
                  itemBuilder: (contex, index) {
                    final foods = state.food[index];
              
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => DetailPage(
                          //       title: foods.title,
                          //       image: foods.image,
                          //       address: foods.address,
                          //       description: foods.description,
                          //       history: foods.history,
                          //       feature: foods.feature,
                          //     ),
                          //   ),
                          // );
                        },
                        child: cardPopular(
                          CachedNetworkImage(
                            imageUrl: foods.image[0],
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
                          foods.title,
                          SvgPicture.asset(
                            AppAssets.Vn,
                            width: 20,
                            height: 20,
                          ),
                          foods.address[1],
                        ),
                      ),
                    );
                  }),
            );
          } else if (state is PopularFoodError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: Text('OK'),
            );
          }
        },
      );
    
  }
}
