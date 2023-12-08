import 'dart:async';

import 'package:chat_app_zaptools/src/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this.chatRepository) : super(UsersInitial());
  ChatRepository chatRepository;

  late StreamSubscription _subscriptionJoined;
  late StreamSubscription _subscriptionLeft;

  @override
  Future<void> close() {
    _subscriptionJoined.cancel();
    _subscriptionLeft.cancel();
    return super.close();
  }

  void requestJoinRoom(String userName){
    chatRepository.joinToChat(userName);
  }

  void listenUsersJoined(){
    _subscriptionJoined = chatRepository.usersJoined().listen((event) { 
      if(event == null) return;
      emit(UserJoinedState(event));
    });
  }

  void listenUsersLeft(){
    _subscriptionLeft = chatRepository.userLeft().listen((data) { 
      emit(UserLeftState(data));
    });
  }

  void connect(){
    chatRepository.connectWithServer();
  }

  void disconnect(){
    chatRepository.disconnectFromTheServer();
  }
  

}
