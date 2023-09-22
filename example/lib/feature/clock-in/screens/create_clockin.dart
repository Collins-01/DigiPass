import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/components/button.dart';
import 'package:flutter_nfc_kit_example/helpers/components/input_field.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/page_layout.dart';
import 'package:flutter_nfc_kit_example/helpers/snakbars.dart';
import 'package:flutter_nfc_kit_example/helpers/util_helpers.dart';

class CreateClockInSession extends StatefulWidget {
  const CreateClockInSession({Key? key}) : super(key: key);

  @override
  State<CreateClockInSession> createState() => _CreateClockInSessionState();
}

class _CreateClockInSessionState extends State<CreateClockInSession> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _roomTitleController = TextEditingController();
  TextEditingController _roomCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: "Create Exam Session",
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              controller: _roomTitleController,
              hintText: "Room title",
            ),
            InputField(
              controller: _roomCodeController,
              hintText: "Room Code",
            ),
            SizedBox(
              height: 10.0,
            ),
            AppButton(
              loading: _loading,
              title: "Create",
              onPress: () {
                if (_formkey.currentState!.validate()) {
                  createSession(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  bool _loading = false;

  createSession(
    context,
  ) async {
    setState(() {
      _loading = true;
    });
    final _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("token");
    final data = {
      "room_title": _roomTitleController.text.trim(),
      "room_code": _roomCodeController.text.trim(),
      "invigilator": token,
      "createdAt": DateTime.now(),
      "updatedAT": DateTime.now(),
      "status": true
    };
    final req = await firestore
        .collection("clock-in-session")
        .doc()
        .set(data)
        .whenComplete(() {
      defaultSnackyBar(context, "Session created", primaryColor);
      Navigator.pop(context);
    }).catchError((err) {
      setState(() {
        _loading = false;
      });
    });
  }
}
