import 'package:chat_app_zaptools/src/users_cubit/users_cubit.dart';
import 'package:flutter/material.dart';

void userStateListener(BuildContext context, UsersState state){
  if (state is UserJoinedState){
     final scaffoldMessenger = ScaffoldMessenger.of(context);
     final materialBanner = MaterialBanner(
      content: Text(
        "${state.senderName} joined ${String.fromCharCode(128640)}",
        style: const TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.bold),
      ), 
      backgroundColor: Colors.green,
      actions: [
        IconButton(
          onPressed: () => scaffoldMessenger.clearMaterialBanners(), 
          icon: const Icon(Icons.close)
        )
      ],
      onVisible: (){
        Future.delayed(const Duration(milliseconds: 1500)).then(
          (value) => scaffoldMessenger.clearMaterialBanners()
        );
      },
      );
     scaffoldMessenger.showMaterialBanner(materialBanner);
     return;
  }

  if(state is UserLeftState){
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final materialBanner = MaterialBanner(
    content: Text(
      "${state.senderName} left chat ${String.fromCharCode(128128)}",
      style: const TextStyle(
        color: Colors.white, 
        fontWeight: FontWeight.bold),
    ), 
    backgroundColor: Colors.red.shade400,
    actions: [
      IconButton(
        onPressed: () => scaffoldMessenger.clearMaterialBanners(), 
        icon: const Icon(Icons.close)
      )
    ],
    onVisible: (){
      Future.delayed(const Duration(milliseconds: 1500)).then(
        (value) => scaffoldMessenger.clearMaterialBanners()
      );
    },
    );
   scaffoldMessenger.showMaterialBanner(materialBanner);
   return;
  }

}