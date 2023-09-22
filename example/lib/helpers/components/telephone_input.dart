import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:flutter_nfc_kit_example/helpers/util_helpers.dart';

class TelephoneInput extends StatefulWidget {
  final String? hintText;
  final String? title;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final double titleSpacing;
  final TextEditingController? controller;
  final Function? validator;
  bool readOnly;

  TelephoneInput(
      {this.hintText,
      this.title,
      this.titleFontSize = 14.0,
      this.titleFontWeight = FontWeight.w400,
      this.titleSpacing = 10,
      this.controller,
      this.readOnly = false,
      this.validator});

  @override
  _TelephoneInputState createState() => _TelephoneInputState();
}

class _TelephoneInputState extends State<TelephoneInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != ""
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title!,
                      style: textStyle(
                          color: textColor,
                          fontSize: widget.titleFontSize,
                          fontWeight: widget.titleFontWeight),
                    ),
                    SizedBox(
                      height: widget.titleSpacing,
                    ),
                  ],
                )
              : const Text(""),
          SizedBox(
            // height: 60,
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.phone,
              readOnly: widget.readOnly,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              style: textStyle(color: textColor),
              decoration: secondaryDecoration.copyWith(
                hintText: widget.hintText,
                hintStyle: textStyle(
                    color: const Color(0xff818181),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
                fillColor: inputFieldBoderColor,
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              controller: widget.controller,
              validator: validateMobile,
            ),
          )
        ],
      ),
    );
  }

  String? validateMobile(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value!.length == 0) {
      return '*Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return '*Please enter valid mobile number';
    }
    return null;
  }
}
