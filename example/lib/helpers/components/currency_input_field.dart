import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:flutter_nfc_kit_example/helpers/util_helpers.dart';

class CurencyInputField extends StatefulWidget {
  final String? hintText;
  final String title;
  final titleFontSize;
  final titleFontWeight;
  final TextEditingController? controller;
  final Function? validator;
  final prefix;
  final suffix;
  bool digitOnly, passwordInput, readOnly, currencyInput;
  int maxLine;
  final double titleSpacing;

  CurencyInputField(
      {this.hintText,
      this.title = "",
      this.titleFontSize = 17.0,
      this.titleFontWeight = FontWeight.w500,
      this.titleSpacing = 10,
      this.controller,
      this.validator,
      this.prefix,
      this.suffix,
      this.digitOnly = false,
      this.passwordInput = false,
      this.currencyInput = true,
      this.readOnly = false,
      this.maxLine = 1});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<CurencyInputField> {
  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, name: "NGN")
          .currencySymbol;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title != ""
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
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
              : Text(""),
          Container(
            // height: 60,
            // color: inputFieldBoderColor,
            child: TextFormField(
              style:
                  textStyle(color: widget.readOnly ? Colors.grey : textColor),
              maxLines: widget.maxLine,
              readOnly: widget.readOnly,
              obscureText: widget.passwordInput,
              keyboardType: widget.digitOnly
                  ? TextInputType.phone
                  : widget.maxLine == 1
                      ? TextInputType.text
                      : TextInputType.multiline,
              inputFormatters: widget.digitOnly
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : null, // Only numbers can be entered
              // textCapitalization: TextCapitalization.sentences,
              // decoration: InputDecoration(prefixText: _currency),
              decoration: secondaryDecoration.copyWith(
                // prefixText: widget.currencyInput ? "NGN" : "",
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    color: const Color.fromRGBO(74, 74, 74, 0.15),
                    fontSize: 12.0),
                prefix: Container(
                  height: 10.0,
                  // color:Colors.red,
                  child: SvgPicture.asset(
                    "assets/savings/naira.svg",
                    color: Colors.grey,
                    width: 9.0,
                  ),
                ),
                suffix: widget.suffix ?? null,
                fillColor: inputFieldBoderColor,
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
              controller: widget.controller,
              onChanged: (string) {
                // print("$string");
                widget.controller!.text = string.trim();

                if (widget.currencyInput) {
                  string = '${_formatNumber(string.replaceAll(',', ''))}';
                  widget.controller!.value = TextEditingValue(
                    text: string,
                    selection: TextSelection.collapsed(offset: string.length),
                  );
                }
              },
              validator: (val) {
                if (val!.trim().isEmpty) {
                  return '* required';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
