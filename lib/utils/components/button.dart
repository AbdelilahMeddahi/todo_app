import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonName;
  VoidCallback onPressed;

  ButtonWidget({Key? key, required this.onPressed, required this.buttonName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Color(0xFFFFECEF),
      child: Text(buttonName,style: TextStyle(color: Colors.black),),
      onPressed: onPressed,
    );
  }
}
