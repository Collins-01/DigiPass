import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';

Future<bool?> pageToast(message, color) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

defaultSnackyBar(context, message, color) {
  final snackBar = SnackBar(
    backgroundColor: color ?? textColor,
    content: Row(
      children: [
        Expanded(
            child: Text(
          '${message ?? "An error occured"}\n',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: textStyle(fontSize: 16.0),
        )),
      ],
    ),
    // action: SnackBarAction(
    //   label: 'Close',
    //   textColor:Colors.white,
    //   onPressed: () {
    //     // Some code to undo the change.
    //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //   },
    // ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
