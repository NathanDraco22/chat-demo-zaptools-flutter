import 'package:chat_app_zaptools/src/repository/chat_repository.dart';
import 'package:chat_app_zaptools/src/screen/chat_screen.dart';
import 'package:chat_app_zaptools/src/service/websocket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()  {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  RepositoryProvider(
      create: (context) => ChatRepository(webSocketService: WebSocketService()),
        child: const MaterialApp(
          title: 'Zap Chat Demo',
          debugShowCheckedModeBanner: false,
          home: ChatScreen()
        ),
    );
  }
}