import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/festivals_bloc/festival_event.dart';
import 'package:ui_project/application/festivals_bloc/festival_state.dart';
import 'package:ui_project/data/repositories/home_repositories/festival_repositories.dart';

class PopularFestivalBloc
    extends Bloc<PopularFestivalEvent, PopularFestivalState> {
  final PopularFestivalRepositories repositories;

  PopularFestivalBloc({required this.repositories})
      : super(PopularFestivalInitial()) {
    on<LoadedPopularFestival>(_onFetch);
    on<LoadedAllFestival>(_onFetchList);
    on<SearchFestivalsEvent>(_onSearch);
  }

  void _onFetch(
      LoadedPopularFestival event, Emitter<PopularFestivalState> emit) async {
    emit(PopularFestivalLoading());
    try {
      final festivals = await repositories.getPopularFestivals();
      emit(PopularFestivalLoaded(festivals));
    } catch (e) {
      emit(PopularFestivalError(e.toString()));
    }
  }

  void _onFetchList(
      LoadedAllFestival event, Emitter<PopularFestivalState> emit) async {
    emit(PopularFestivalLoading());
    try {
      final festivals = await repositories.getListFestival();
      emit(PopularFestivalLoaded(festivals));
    } catch (e) {
      emit(PopularFestivalError(e.toString()));
    }
  }

  void _onSearch(
      SearchFestivalsEvent event, Emitter<PopularFestivalState> emit) async {
    emit(PopularFestivalLoading());

    try {
      final festivals = await repositories.searchByTitle();

      emit(PopularFestivalLoaded(festivals));
      print('Search results: $festivals');
    } catch (e) {
      emit(PopularFestivalError(e.toString()));
    }
  }
}
