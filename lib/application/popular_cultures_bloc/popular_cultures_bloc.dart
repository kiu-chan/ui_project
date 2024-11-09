import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/popular_cultures_bloc/popular_cultures_event.dart';
import 'package:ui_project/application/popular_cultures_bloc/popular_cultures_state.dart';
import 'package:ui_project/data/repositories/popular_cultures_repositories.dart';

class PopularCulturesBloc
    extends Bloc<PopularCulturesEvent, PopularCultureState> {
  final PopularCultureRepositories repositories;

  PopularCulturesBloc({required this.repositories})
      : super(PopularCultureInitial()) {
    on<LoadedPopularCultures>(_onFetch);
    on<LoadedAllCultures>(_onFetchList);
    
  }

  // List the popular culture
  void _onFetch(
      LoadedPopularCultures event, Emitter<PopularCultureState> emit) async {
    emit(PopularCultureLoading());
    try {
      final cultures = await repositories.getPopularCultures();
      emit(PopularCultureLoaded(cultures));
    } catch (e) {
      emit(PopularCultureError(e.toString()));
    }
  }

  // List all the culture
  void _onFetchList(
      LoadedAllCultures envet, Emitter<PopularCultureState> emit) async {
    emit(PopularCultureLoading());

    try {
      final cultures = await repositories.getListCulture();
      emit(PopularCultureLoaded(cultures));
    } catch (e) {
      emit(PopularCultureError(e.toString()));
    }
  }
}
