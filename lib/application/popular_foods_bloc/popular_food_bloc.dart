import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/popular_foods_bloc/popular_food_event.dart';
import 'package:ui_project/application/popular_foods_bloc/popular_food_state.dart';
import 'package:ui_project/data/repositories/popular_food_repositories.dart';

class PopularFoodBloc extends Bloc<PopularFoodEvent, PopularFoodState> {
  final PopularFoodRepositories repositories;
  PopularFoodBloc({required this.repositories}) : super(PopularFoodInitial()) {
    on<LoadedPopularFood>(_onFetch);
  }

  void _onFetch(LoadedPopularFood event, Emitter<PopularFoodState> emit) async {
    emit(PopularFoodLoading());
    try {
      final foods = await repositories.getPopularFoods();
      emit(PopularFoodLoaded(foods));
    } catch (e) {
      emit(PopularFoodError(e.toString()));
    }
  }
}
