import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:flutter_nfc_kit_example/helpers/util_helpers.dart';

class EmailInputField extends StatefulWidget {
  final String? hintText;
  final String? title;
  final double titleSpacing;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final TextEditingController? controller;
  bool readOnly;

  EmailInputField(
      {this.hintText = "",
      this.title = "",
      this.titleFontSize = 14.0,
      this.titleFontWeight = FontWeight.w400,
      this.titleSpacing = 5,
      this.readOnly = false,
      this.controller});

  @override
  _EmailInputFieldState createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != ""
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
            height: widget.titleSpacing,
          ),
          TextFormField(
            readOnly: widget.readOnly,
            style: textStyle(color: textColor),
            decoration: secondaryDecoration.copyWith(
              hintText: widget.hintText,
              hintStyle: textStyle(
                  color: const Color(0xff818181),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
              // prefix: widget.prefix ?? null,
              // suffix: widget.suffix ?? null,
              fillColor: inputFieldBoderColor,
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            controller: widget.controller,
            validator: (val) => EmailValidator.validate(val!.trim())
                ? null
                : "* Please enter a valid email",
          )
        ],
      ),
    );
  }
}
