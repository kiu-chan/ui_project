import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/popular_festivals_bloc/popular_festival_event.dart';
import 'package:ui_project/application/popular_festivals_bloc/popular_festival_state.dart';
import 'package:ui_project/data/repositories/popular_festival_repositories.dart';

class PopularFestivalBloc
    extends Bloc<PopularFestivalEvent, PopularFestivalState> {
  final PopularFestivalRepositories repositories;

  PopularFestivalBloc({required this.repositories})
      : super(PopularFestivalInitial()) {
    on<LoadedPopularFestival>(_onFetch);
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
}
