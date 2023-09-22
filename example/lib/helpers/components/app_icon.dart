import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({Key? key, this.width = 130.0}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: Image.asset('assets/logo/logo.png'));
  }
}
