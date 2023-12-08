import 'package:chat_app_zaptools/src/chat_bloc/chat_bloc.dart';
import 'package:chat_app_zaptools/src/model/chat_mode.dart';
import 'package:chat_app_zaptools/src/repository/chat_repository.dart';
import 'package:chat_app_zaptools/src/screen/actions/user_state_listener.dart';
import 'package:chat_app_zaptools/src/screen/widgets/chat_bubble.dart';
import 'package:chat_app_zaptools/src/screen/widgets/chat_zone.dart';
import 'package:chat_app_zaptools/src/screen/widgets/init_name_alert.dart';
import 'package:chat_app_zaptools/src/screen/widgets/input_zone.dart';
import 'package:chat_app_zaptools/src/users_cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          final chatRepo = context.read<ChatRepository>();
          return ChatBloc(chatRepo);
        }),

        BlocProvider(create: (context) {
          final chatRepo = context.read<ChatRepository>();
          return UsersCubit(chatRepo);
        })

      ],
      child: const _ChatScreenScafold(),
    );
  }
}

class _ChatScreenScafold extends StatelessWidget {
  const _ChatScreenScafold();

  @override
  Widget build(BuildContext context) {
    Future(()=> showDialog(
      context: context, 
      builder:  (context) => AlertDialog(
        title: const Text("Tap on 'Active switch' to init connection"),
        actions: [
          TextButton(
            onPressed: ()=> Navigator.pop(context), 
            child: const Text("OK")
          )
        ],
      ),)
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Demo", style: TextStyle(color: Colors.white),), 
        backgroundColor: Colors.teal,
        actions: const [
          Text("Activate", 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: Colors.white),
          ),
          SwitchConnection(),
          _StatusChecker(),
          SizedBox(width: 10,)
        ],
      ),
      body: const _ChatScreenBody(),
    );
  }
}

class SwitchConnection extends StatelessWidget {
  const SwitchConnection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UsersCubit>();
    bool currentValue = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return Switch(
          value: currentValue , 
          onChanged: (value) async {
            currentValue = value;
            if(!currentValue){
              userCubit.disconnect();
              setState((){});
              return;
            }

            userCubit.connect();
            setState((){});
            await showDialog(
              barrierDismissible: false,
              context: context, 
              builder: (_) =>  EnterNameAlert(
                (text){
                  context.read<UsersCubit>()
                    ..requestJoinRoom(text)
                    ..listenUsersJoined()
                    ..listenUsersLeft()
                  ;
                }
              )
            );            
          },
        );
      }
    );
  }
}

class _StatusChecker extends StatelessWidget {
  const _StatusChecker();

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(CheckConnection());
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final isConnected = state.isConnected;
        final (text, color) = isConnected
                            ? ("Online", Colors.green) 
                            : ("Offline", Colors.red);
        return Row(children: [
          Text(text, 
            style: const TextStyle(color: Colors.white,),
          ),
          const SizedBox(width: 4,),
          CircleAvatar(
            radius: 8,
            backgroundColor: color,
          )
        ],);
      },
    );
  }
}

class _ChatScreenBody extends StatefulWidget {
  const _ChatScreenBody();

  @override
  State<_ChatScreenBody> createState() => _ChatScreenBodyState();
}

class _ChatScreenBodyState extends State<_ChatScreenBody> with TickerProviderStateMixin {
  
  List<ChatBubble> chatBubbles = [];

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(StartEvent());
    Future.delayed(const Duration(seconds: 3)).then((value){
    context.read<UsersCubit>()
                  ..listenUsersJoined()
                  ..listenUsersLeft();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listenWhen: (prev, current) => prev.chats.length != current.chats.length,
      listener: (_ , state){
        if(state.chats.isEmpty) return;
        final lastBubble = chatToBubble(state.chats.last);
        chatBubbles.insert(0, lastBubble);
        setState(() {});
      },
       child: BlocListener<UsersCubit, UsersState>(
         listener: userStateListener,
         child: Column(
          children: [
            ChatsZone(chatBubbles),
            InputsZone(onPressSend: (value) {
              context.read<ChatBloc>().add(SendMessage(value));
            })
          ],
        ),
      )
    );
  }

  ChatBubble chatToBubble( ChatModel chatModel ){
     return ChatBubble(
       uid: chatModel.senderId,
       content: chatModel.message,
       senderName: chatModel.senderName,
       animationController: AnimationController(
         vsync: this, 
         duration: const Duration(milliseconds: 300)
       )..forward()
     );
   }
   
}


  

