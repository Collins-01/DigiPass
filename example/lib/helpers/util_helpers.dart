import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/components/button.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:flutter_nfc_kit_example/welcome.dart';
import 'package:intl/intl.dart';

var formatter = NumberFormat.decimalPattern('en_us');
const secondaryDecoration = InputDecoration(
    contentPadding: EdgeInsets.all(50.0),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: inputFieldBoderColor1, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(5))),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: inputFieldBoderColor1, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(5))),
    disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: inputFieldBoderColor1, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(5))),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: inputFieldBoderColor1, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(5))),
    filled: true,

    // fillColor: Color.fromRGBO(196, 196, 196, 0.1),
    fillColor: inputFieldBoderColor1,
    hintStyle: TextStyle(color: Colors.black));

const secondaryDecorationForSearch = InputDecoration(
    contentPadding: EdgeInsets.only(top: 5),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
        borderRadius: BorderRadius.all(Radius.circular(5))),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(5))),
    disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(5))),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(5))),
    filled: true,

    // fillColor: Color.fromRGBO(196, 196, 196, 0.1),
    fillColor: Colors.transparent,
    hintStyle: TextStyle(color: Colors.black));
// const baseUrl = 'https://bank.flutter_nfc_kit_example.com';
FirebaseFirestore firestore = FirebaseFirestore.instance;
