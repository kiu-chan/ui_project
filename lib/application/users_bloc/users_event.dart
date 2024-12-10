import 'package:equatable/equatable.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

class LoadedUsersInfo extends UsersEvent {
  final int userId;

  const LoadedUsersInfo(this.userId);

  @override
  List<Object?> get props => [userId];
}


