import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_project/application/foods_bloc/food_bloc.dart';
import 'package:ui_project/application/foods_bloc/food_event.dart';
import 'package:ui_project/application/foods_bloc/food_state.dart';
import 'package:ui_project/application/saved_cubit/saved_foods_cubit.dart';
import 'package:ui_project/core/constant/loading.dart';
import 'package:ui_project/data/models/Home/food_model.dart';
import 'package:ui_project/presentation/widgets/custome_appbar.dart';
import 'package:ui_project/presentation/widgets/detail_food.dart';
import 'package:ui_project/presentation/widgets/list_page.dart';

import '../../../../core/constant/assets.dart';

class ListFoodsScreen extends StatelessWidget {
  const ListFoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PopularFoodBloc>().add(
          LoadedAllFoods(),
        );
    return Scaffold(
      appBar: CustomeAppbar(
        title: 'Ẩm thực',
      ),
      body: BlocBuilder<PopularFoodBloc, PopularFoodState>(
          builder: (context, state) {
        if (state is PopularFoodLoading) {
          return const Center(
            child: AppLoading.loading,
          );
        } else if (state is PopularFoodLoaded) {
          return ListView.builder(
              itemCount: state.food.length,
              itemBuilder: (context, index) {
                final foods = state.food[index];
                return ListPage(
                  address: foods.address,
                  image: foods.image[0],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailFoodPage(
                          title: foods.title,
                          image: foods.image,
                          address: foods.address,
                          description: foods.description,
                          history: foods.history,
                          feature: foods.feature[1],
                          ingredients: foods.ingredients,
                        ),
                      ),
                    );
                  },
                  title: foods.title,
                  widget: Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: BlocBuilder<SavedFoodsCubit, List<FoodModel>>(
                        builder: (context, state) {
                          final isSaved =
                              state.any((item) => item.image == foods.image);
                          return IconButton(
                            onPressed: () {
                              context
                                  .read<SavedFoodsCubit>()
                                  .toogleSave(context, foods);
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
              });
        } else if (state is PopularFoodError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return const Center(
            child: Text('No data'),
          );
        }
      }),
    );
  }
}
