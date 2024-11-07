import 'package:equatable/equatable.dart';

abstract class PopularCulturesEvent extends Equatable {
  const PopularCulturesEvent();

  @override
  List<Object?> get props => [];
}

class LoadedPopularCultures extends PopularCulturesEvent {
  const LoadedPopularCultures();

  @override
  List<Object?> get props => [];
}
