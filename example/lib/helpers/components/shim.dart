import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class Shimmy extends StatelessWidget {
  double? width, height;
  final Color? color;
  Shimmy({this.height, this.width, this.color = Colors.grey});
  @override
  Widget build(BuildContext context) {
    return Shimmer(
        duration: const Duration(seconds: 2), //Default value
        interval: const Duration(seconds: 1), //Default value: Duration(seconds: 0)
        // color: Color(0xFFFafafa),
        color:color!, //Default value
        colorOpacity: 0.3, //Default value
        enabled: true, //Default value
        direction: const ShimmerDirection.fromLTRB(), //Default Value
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: const Color(0xFFf5f5f5),
            // color:Colors.red
          ),
          width: width,
          height: height,
        ),);
  }
}

