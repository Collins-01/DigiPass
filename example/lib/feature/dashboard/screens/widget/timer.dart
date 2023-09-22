import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_nfc_kit_example/feature/onboarding/screens/sign_in.dart';
import 'package:flutter_nfc_kit_example/feature/onboarding/services/auth_services.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:flutter_nfc_kit_example/helpers/snakbars.dart';

class TimeoutTimer extends StatefulWidget {
  const TimeoutTimer({Key? key}) : super(key: key);

  @override
  State<TimeoutTimer> createState() => _TimeoutTimerState();
}

class _TimeoutTimerState extends State<TimeoutTimer> {
  CountdownTimerController? controller;
  var sd = 3600;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 50;
  void onEnd() async {
    defaultSnackyBar(context, "Sign-in Timeout.", dangerColor);
    setState(() {});
    //   await FirebaseAuth.instance.signOut();
    //   final req = await AuthServices()
    //       .logoutUser(context)
    //       .then((value) => nextPageNoPop(
    //           context, (context) => SignIn()));
    // // Navigator.pop(context);
    // print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2.0, right: 8),
      // color:Colors.red,
      child: Center(
        child: CountdownTimer(
          controller: controller,
          onEnd: onEnd,
          endTime: endTime,
          textStyle: textStyle(
              color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
