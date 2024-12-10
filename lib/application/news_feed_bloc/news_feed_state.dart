import 'package:equatable/equatable.dart';
import 'package:ui_project/data/models/NewsFeed/news_feed_model.dart';

abstract class NewsFeedState extends Equatable {
  const NewsFeedState();

  @override
  List<Object> get props => [];
}

class NewsFeedInitial extends NewsFeedState {
  const NewsFeedInitial();

  @override
  List<Object> get props => [];
}

class NewsFeedLoading extends NewsFeedState {
  const NewsFeedLoading();

  @override
  List<Object> get props => [];
}

class NewsFeedLoaded extends NewsFeedState {
  final List<NewsFeedModel> data;

  const NewsFeedLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class NewsFeedError extends NewsFeedState {
  final String message;
  const NewsFeedError(this.message);

  @override
  List<Object> get props => [message];
}
