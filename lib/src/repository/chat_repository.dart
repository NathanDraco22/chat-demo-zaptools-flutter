
import 'dart:math';
import 'package:chat_app_zaptools/src/model/chat_mode.dart';
import 'package:chat_app_zaptools/src/service/websocket_service.dart';
import 'package:zaptools_client/zaptools_client.dart';


class ChatRepository {
  final WebSocketService webSocketService;
  ChatRepository({required this.webSocketService}){
    webSocketService.init();
  }

  String name = Random().nextInt(100).toString();

  void connectWithServer(){
      webSocketService.connect();
  }

  sentMessage(String message){
    webSocketService.send(name, message);

  }

  joinToChat(String userName){
    name = userName;
    webSocketService.sendJoinRoom(name);
  }

  Stream<String?> usersJoined() => webSocketService.usersInChat()
    .map((event) => event == name ? null : event);

  Stream<String> userLeft() 
    => webSocketService.userLeftChat();

  Stream<ChatModel> newMessageStream() {
    return webSocketService.eventStream("new-message")
      .map((event) { 
        return ChatModel(
        event.senderId, 
        event.senderName, 
        event.message);
        });
  }

  Stream<bool> checkIfConnected() 
    => webSocketService.statusConnection()
      .map((event) {
        return switch(event){
            ConnectionState.online => true,
            _ => false
         };
      });

  void disconnectFromTheServer(){
    webSocketService.disconnect();
  }

}



