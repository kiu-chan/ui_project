import 'package:equatable/equatable.dart';

abstract class PopularFoodEvent extends Equatable {
  const PopularFoodEvent();

  @override
  List<Object?> get props => [];
}

class LoadedPopularFood extends PopularFoodEvent {
  const LoadedPopularFood();

  @override
  List<Object?> get props => [];
}
