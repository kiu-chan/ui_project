import 'package:equatable/equatable.dart';

abstract class NewsFeedEvent extends Equatable {
  const NewsFeedEvent();

  @override
  List<Object?> get props => [];
}

class LoadedAllNews extends NewsFeedEvent {
  const LoadedAllNews();

  @override
  List<Object?> get props => [];
}


