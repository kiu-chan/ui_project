import "package:equatable/equatable.dart";

abstract class PopularDestinationEvent extends Equatable {
  const PopularDestinationEvent();
  @override
  List<Object?> get props => [];
}

class LoadPopularDestination extends PopularDestinationEvent {
  const LoadPopularDestination();

  @override
  List<Object?> get props => [];
}
