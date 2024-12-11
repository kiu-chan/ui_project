import 'package:equatable/equatable.dart';
import '../../data/models/Users/users_model.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {
  const UsersInitial();

  @override
  List<Object> get props => [];
}

class UsersLoading extends UsersState {
  const UsersLoading();

  @override
  List<Object> get props => [];
}

class UsersLoaded extends UsersState {
  final UsersModel user;

  const UsersLoaded(this.user);

  @override
  List<Object> get props => [user];
}


class UsersError extends UsersState {
  final String message;
  const UsersError(this.message);

  @override
  List<Object> get props => [message];
}
