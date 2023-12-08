
class ChatModel {

  final String senderId;
  final String senderName;
  final String message;

  ChatModel(this.senderId, this.senderName, this.message);

  ChatModel.fromJsonMap( Map<String, dynamic> jsonMap ) :
    senderId = jsonMap['senderId'],
    senderName = jsonMap['senderName'],
    message = jsonMap["message"];


}