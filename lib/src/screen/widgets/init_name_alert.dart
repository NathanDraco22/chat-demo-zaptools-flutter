import 'package:flutter/material.dart';




class EnterNameAlert extends StatelessWidget {
  const EnterNameAlert(this.onConfirm ,{super.key});

  final void Function(String text) onConfirm;

  @override
  Widget build(BuildContext context) {
    String name = "";
    return AlertDialog(
      title: const Text("Put Your Nickname"),
      content: TextField(
        onChanged: (value) => name = value,
        decoration: const InputDecoration(
          labelText: "Nickname",
          border: OutlineInputBorder()
        ),
      ),
      actions: [
        TextButton.icon(
          onPressed: (){
            if(name.isEmpty ) return;
            onConfirm(name);
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.check), 
          label: const Text("OK")
        )
      ],
    );
  }
}







