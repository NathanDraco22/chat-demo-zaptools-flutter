import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    Key? key,
    required this.uid,
    required this.content,
    required this.senderName,
    required this.animationController
  }) : super(key: key);

  final String uid;
  final String content;
  final String senderName;
  final AnimationController animationController;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble>{
  
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animationController,
      child: FadeTransition(
        opacity: widget.animationController,
        child: widget.uid == "123" 
          ? _MyMessage(widget.content) 
          : _FromOtherMessage(widget.content, widget.senderName),
        
        ),
    );
  }
}


//.............................................................................


class _MyMessage extends StatelessWidget {
  const _MyMessage(this.content,{Key? key}) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only( left: 50, bottom: 4, right: 8),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue.shade600
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("You", style: TextStyle(color: Colors.purple.shade800)),
            Text(content, 
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.right,
            ),
          ],
        ) ,
      ),
    );
  }
}

//..............................................................................

class _FromOtherMessage extends StatelessWidget {
  const _FromOtherMessage(this.content,this.senderName,{Key? key}) : super(key: key);

  final String content;
  final String senderName;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only( left: 8, bottom: 12, right: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade400
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(senderName, style: const TextStyle(color: Colors.blueAccent),),
            Text(content, style: const TextStyle(color: Colors.black87),),
          ],
        ) ,
      ),
    );
  }
}
