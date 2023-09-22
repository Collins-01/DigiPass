import 'package:flutter/material.dart';

class AppButton1 extends StatelessWidget {
  const AppButton1({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.blue,
        onSurface: Colors.red,
      ),
      onPressed: () { },
      child: const Text('TextButton'),
    );
  }
}