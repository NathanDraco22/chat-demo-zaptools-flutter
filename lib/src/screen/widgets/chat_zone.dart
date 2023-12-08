import 'package:flutter/material.dart';
import 'chat_bubble.dart';

class ChatsZone extends StatelessWidget {
  const ChatsZone( 
    this.chats,{
    Key? key,
  }) : super(key: key);


  final List<ChatBubble> chats;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ColoredBox(
        color: Colors.yellow.shade50,
        child: ListView.builder(
          itemCount: chats.length,
          physics: const BouncingScrollPhysics(),
          reverse: true,
          itemBuilder: ( _ , i) => chats[i]
        ),
      )
    );
  }
}




