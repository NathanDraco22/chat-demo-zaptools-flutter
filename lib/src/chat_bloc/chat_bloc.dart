import 'package:chat_app_zaptools/src/model/chat_mode.dart';
import 'package:chat_app_zaptools/src/repository/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "chat_event.dart";
part "chat_state.dart";

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  ChatBloc(this.chatRepository) : super(ChatInitial()) {

    on<StartEvent>((event,emit)async {
      await emit.forEach(
        chatRepository.newMessageStream(), 
        onData: (chat) {
          return state.copyWith(chats: [...state.chats, chat], lastChat: chat);
        }
      );
    });

    on<CheckConnection>((event, emit)async{
      await emit.forEach(
        chatRepository.checkIfConnected(), 
        onData: (value) {
          return state.copyWith(isConnected: value);
        }
      );
    });


    on<SendMessage>((event, emit) {
      final chatModel = ChatModel(
        "123",
        "me",
        event.message
      );
      chatRepository.sentMessage(event.message);
      emit(state.copyWith(chats: [...state.chats, chatModel], lastChat: chatModel));

    });

  }
}



