import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/foods_bloc/food_event.dart';
import 'package:ui_project/application/foods_bloc/food_state.dart';
import 'package:ui_project/data/repositories/home_repositories/food_repositories.dart';

class PopularFoodBloc extends Bloc<PopularFoodEvent, PopularFoodState> {
  final PopularFoodRepositories repositories;

  PopularFoodBloc({required this.repositories}) : super(PopularFoodInitial()) {
    on<LoadedPopularFood>(_onFetch);
    on<LoadedAllFoods>(_onFetchList);
    on<SearchFoodsEvent>(_onSearch);
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

  void _onFetchList(
      LoadedAllFoods event, Emitter<PopularFoodState> emit) async {
    emit(PopularFoodLoading());
    try {
      final foods = await repositories.getListFood();
      emit(PopularFoodLoaded(foods));
    } catch (e) {
      emit(PopularFoodError(e.toString()));
    }
  }

  void _onSearch(SearchFoodsEvent event, Emitter<PopularFoodState> emit) async {
    emit(PopularFoodLoading());

    try {
      final foods = await repositories.searchFoodsByTitle(event.query);

      emit(PopularFoodLoaded(foods));
      print('Search results: $foods');
    } catch (e) {
      emit(PopularFoodError(e.toString()));
    }
  }
}
