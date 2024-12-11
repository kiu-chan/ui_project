import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/news_feed_bloc/news_feed_event.dart';
import 'package:ui_project/application/news_feed_bloc/news_feed_state.dart';
import 'package:ui_project/data/repositories/explore_repositories/news_feed_repositories.dart';

class NewsFeedBloc extends Bloc<NewsFeedEvent, NewsFeedState> {
  final NewsFeedRepositories repositories;

  NewsFeedBloc({required this.repositories}) : super(NewsFeedInitial()) {
    on<LoadedAllNews>(_onFetch);
  }

  void _onFetch(LoadedAllNews event, Emitter<NewsFeedState> emit) async {
    emit(NewsFeedLoading());
    try {
      final data = await repositories.getData();
      emit(
        NewsFeedLoaded(data),
      );
    } catch (e) {
      emit(
        NewsFeedError(e.toString()),
      );
    }
  }
}

