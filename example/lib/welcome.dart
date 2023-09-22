import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit_example/feature/onboarding/screens/sign_in.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/components/app_icon.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/page_layout.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        Duration(seconds: 2),
        () => {
              nextPageNoPop(context, (context) => SignIn()),
            });
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      noAppBar: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: AppIcon()),
          Center(
            child: Container(
              width: 100.0,
              child: Center(
                  child: CupertinoActivityIndicator(
                      key: UniqueKey(), radius: 10.0)),
            ),
          )
        ],
      ),
    );
  }
}
