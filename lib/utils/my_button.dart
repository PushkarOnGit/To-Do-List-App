import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final String text;
  VoidCallback onPressed;

  MyButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: Colors.white,
      onPressed: onPressed,
      child: Text(text,),
    );
  }
}
