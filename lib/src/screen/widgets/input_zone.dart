
import 'package:flutter/material.dart';


//==============================================================================

class InputsZone extends StatefulWidget {

  const InputsZone({
    Key? key,
    required this.onPressSend
  }) : super(key: key);


  final void Function(String textBoxValue) onPressSend;

  @override
  State<InputsZone> createState() => _InputsZoneState();
}

class _InputsZoneState extends State<InputsZone> {


  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool isEmptyBox = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 4),
            height: 44,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(30)
            ),
            child:  TextField(
              textInputAction: TextInputAction.send,
              focusNode: focusNode,
              onSubmitted: (value) {
                if(value.isEmpty) return;
                _sendButtonPressed();
                focusNode.requestFocus();
              }, 
              onChanged: _changeText,
              controller: _textEditingController,
              decoration: const InputDecoration( 
                border: InputBorder.none
               ),
             )
            
          ),
        ),

        IconButton(
          disabledColor: Colors.black87 ,
          color: Colors.blue,
          padding: EdgeInsets.zero,
          splashRadius: 24,
          onPressed: isEmptyBox ? null : _sendButtonPressed, 
          icon: const Icon(Icons.send)) 
      ],
    );
  }

  void _changeText( String value ){
    if (value.trim().isNotEmpty){
      setState(() {isEmptyBox = false;});
      return;
    }
    isEmptyBox = true;
    setState(() {});
  }

  _sendButtonPressed(){
    widget.onPressSend(_textEditingController.text);
    _textEditingController.clear();
    isEmptyBox = true;
  }

}

//==============================================================================

