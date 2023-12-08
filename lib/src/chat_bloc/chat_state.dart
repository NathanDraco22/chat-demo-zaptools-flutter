part of 'chat_bloc.dart';

sealed class ChatState{
  final List<ChatModel> chats;
  final ChatModel? lastChat;
  final bool isConnected;
  ChatState({required this.chats, this.lastChat, required this.isConnected});

  ChatState  copyWith({ List<ChatModel>? chats,bool? isConnected, ChatModel? lastChat}){
    return SetChatState(
      chats: chats ?? this.chats, 
      lastChat: lastChat, 
      isConnected: isConnected ?? this.isConnected);
  }

}

final class ChatInitial extends ChatState{
  ChatInitial({super.chats = const [], super.isConnected = false});
}

final class SetChatState extends ChatState{
  SetChatState({required super.chats, required super.isConnected ,super.lastChat});
}