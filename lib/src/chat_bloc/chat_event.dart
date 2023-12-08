part of 'chat_bloc.dart';


sealed class ChatEvent {}

final class StartEvent extends ChatEvent{}
final class CheckConnection extends ChatEvent{}

final class SendMessage extends ChatEvent {
  final String message;
  SendMessage(this.message);

}
