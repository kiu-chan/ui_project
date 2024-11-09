import 'package:equatable/equatable.dart';

abstract class PopularFestivalEvent extends Equatable {
  const PopularFestivalEvent();

  @override
  List<Object?> get props => [];
}

class LoadedPopularFestival extends PopularFestivalEvent {
  const LoadedPopularFestival();

  @override
  List<Object?> get props => [];
}

class LoadedAllFestival extends PopularFestivalEvent {
  const LoadedAllFestival();

  @override
  List<Object?> get props => [];
}
