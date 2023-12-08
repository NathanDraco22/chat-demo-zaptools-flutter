part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class UserJoinedState extends UsersState{
  final String senderName;
  UserJoinedState(this.senderName);
}

final class UserLeftState extends UsersState{
  final String senderName;
  UserLeftState(this.senderName);
}