import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/popular_destinations_bloc/popular_destination_event.dart';
import 'package:ui_project/application/popular_destinations_bloc/popular_destination_state.dart';
import 'package:ui_project/data/repositories/popular_destionation_repositories.dart';

class PopularDestnationBloc
    extends Bloc<PopularDestinationEvent, PopularDestinationState> {
  final PopularDestionationRepositories repositories;

  PopularDestnationBloc({required this.repositories})
      : super(PopularDestinationInitial()) {
    on<LoadPopularDestination>(_onFetch);
  }

  void _onFetch(LoadPopularDestination event,
      Emitter<PopularDestinationState> emit) async {
    emit(PopularDestinationLoading());
    try {
      final destinations = await repositories.getPopularDestionations();
      emit(PopularDestinationLoaded(destinations));
    } catch (e) {
      emit(PopularDestinationError(e.toString()));
    }
  }
}
