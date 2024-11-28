import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/cultures_bloc/cultures_event.dart';
import 'package:ui_project/application/cultures_bloc/cultures_state.dart';
import 'package:ui_project/data/repositories/home_repositories/cultures_repositories.dart';

class PopularCulturesBloc
    extends Bloc<PopularCulturesEvent, PopularCultureState> {
  final PopularCultureRepositories repositories;

  PopularCulturesBloc({required this.repositories})
      : super(PopularCultureInitial()) {
    on<LoadedPopularCultures>(_onFetch);
    on<LoadedAllCultures>(_onFetchList);
    on<SearchCulturesEvent>(_onSearch);
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

  // Filter
  // void _onFilter(FilterCultures event, Emitter<PopularCultureState> emit) async {
  //   emit(PopularCultureLoading());

  //   try {
  //     final cultures = await repositories.filterCulture();
  //     emit(PopularCultureLoaded());
  //   } catch(e) {
  //     emit(PopularCultureError(e.toString()));
  //   }
  // }

  // Search
  void _onSearch(
      SearchCulturesEvent event, Emitter<PopularCultureState> emit) async {
    emit(PopularCultureLoading());
    try {
      final searchResults =
          await repositories.searchCulturesByTitle(event.query);
      print(
          'Search results: $searchResults'); 
      emit(PopularCultureLoaded(searchResults));
    } catch (e) {
      emit(PopularCultureError(e.toString()));
    }
  }
}
