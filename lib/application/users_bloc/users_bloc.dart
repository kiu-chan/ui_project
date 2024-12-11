import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/application/users_bloc/users_event.dart';
import 'package:ui_project/application/users_bloc/users_state.dart';
import '../../data/repositories/users_repositories/user_repositories.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepositories repositories;

  UsersBloc({required this.repositories}) : super(UsersInitial()) {
    on<LoadedUsersInfo>(_onFetch);
  }

  void _onFetch(LoadedUsersInfo event, Emitter<UsersState> emit) async {
    emit(UsersLoading());
    try {
      final user = await repositories.getUserByUserId(event.userId);
      if (user != null) {
        emit(UsersLoaded(user));
      } else {
        emit(UsersError('User not found'));
      }
    } catch (e) {
      emit(UsersError(e.toString()));
    }
  }

  
}

