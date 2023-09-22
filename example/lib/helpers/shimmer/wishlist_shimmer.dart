import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WishlistShimmer extends StatelessWidget {
  const WishlistShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        WishlistShimmerTab(),
        
      ]);
  }
}


class WishlistShimmerTab extends StatelessWidget {
  const WishlistShimmerTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Row(
        children: [
          
        ],
      ),
    );
  }
}