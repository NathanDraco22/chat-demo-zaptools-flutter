import 'package:zaptools_client/zaptools_client.dart';

typedef MessageRecord = ({
  String message,
  String senderId,
  String senderName

});

class WebSocketService {
  
  late ZapSubscriber sub;
  init(){
    String url = const String.fromEnvironment(
      "HOST", defaultValue: "ws://127.0.0.1:8080/ws") ;
      
    sub = ZapSubscriber(url);
  }

  Stream<ConnectionState> statusConnection() => sub.connectionState;

  Stream<String> usersInChat() => sub.subscribeToEvent("user-joined")
    .map((data)=> data.payload["userName"] ?? "unknow");

  Stream<String> userLeftChat() => sub.subscribeToEvent("user-left")
    .map((data) => data.payload as String)
  ;
  
  sendJoinRoom(String name){
    sub.sendEvent("join-room", {"userName" : name});
  }

  Stream<MessageRecord> eventStream(String eventName) {
    return sub.subscribeToEvent(eventName).map<MessageRecord>(
      (event) 
      => (
        message: event.payload["message"],
        senderId : event.payload["senderId"],
        senderName : event.payload["senderName"]
      )
    );
  }

  void send(
    String senderName,
    String message, {
    Map<String, dynamic>? headers,
  }) {
    const eventName = 'send';
    final payload = {
      "senderName" : senderName,
      "senderId" : "otro",
      "message" : message
    };
    sub.sendEvent(eventName, payload,headers: headers);
  }

  void connect(){
    sub.connect();
  }

  void disconnect(){
    sub.disconnect();
  }


}

