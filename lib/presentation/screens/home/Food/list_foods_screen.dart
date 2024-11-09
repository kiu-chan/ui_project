import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/popular_foods_bloc/popular_food_bloc.dart';
import 'package:ui_project/application/popular_foods_bloc/popular_food_event.dart';
import 'package:ui_project/application/popular_foods_bloc/popular_food_state.dart';
import 'package:ui_project/core/constant/loading.dart';
import 'package:ui_project/presentation/widgets/custome_appbar.dart';
import 'package:ui_project/presentation/widgets/detail_food.dart';
import 'package:ui_project/presentation/widgets/list_page.dart';

class ListFoodsScreen extends StatelessWidget {
  const ListFoodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PopularFoodBloc>().add(LoadedAllFoods(),);
    return Scaffold(
      appBar: CustomeAppbar(
        title: 'Popular Foods',
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
                    address: foods.address[0],
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
                    title: foods.title);
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
