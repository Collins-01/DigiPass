import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:flutter_nfc_kit_example/helpers/util_helpers.dart';

class DropdownField extends StatefulWidget {
  final String? title;
  final List<String?> items;
  final Function(String?)? onChange;
  final String? initValue;
  final double titleFontSize;
  final titleFontWeight;
  final double titleSpacing;

  DropdownField(
      {Key? key,
      this.title,
      required this.items,
      this.onChange,
      this.titleFontSize = 14,
      this.titleFontWeight = FontWeight.w400,
      this.titleSpacing = 10,
      this.initValue})
      : super(key: key);

  @override
  _DropdownFieldState createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String vall = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      vall = widget.initValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: widget.title == ''
                ? null
                : Row(children: [
                    Expanded(
                      child: Text(
                        widget.title!,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: textStyle(
                            color: textColor,
                            fontSize: widget.titleFontSize,
                            fontWeight: widget.titleFontWeight),
                      ),
                    ),
                  ]),
          ),
          SizedBox(
            height: widget.titleSpacing,
          ),
          Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4),
                // border: Border.all(color: Colors.transparent)
              ),
              child: DropdownButtonFormField(
                style: textStyle(
                    color: textColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0),
                icon: const Icon(Icons.expand_more,
                    color: Color.fromRGBO(74, 74, 74, 0.4)),
                hint: const Text("placeholder"),
                decoration: secondaryDecoration.copyWith(
                  hintText: widget.title,
                  hintStyle: textStyle(color: textColor, fontSize: 14),
                  fillColor: inputFieldBoderColor,
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 17),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                ),
                items: widget.items.map((e) {
                  return getDropdownMenu(e);
                }).toList(),
                value: widget.initValue,
                validator: (val) {
                  print("Na initial value b this");
                  print(val);
                  if (val == widget.initValue) {
                    return 'This is required';
                  }
                  return null;
                },
                onChanged: widget.onChange,
                isExpanded: true,
              )),
        ],
      ),
    );
  }

  DropdownMenuItem<String> getDropdownMenu(e) {
    return DropdownMenuItem(
      child: Text(
        e,
        style: textStyle(
          color: textColor,
        ),
      ),
      value: e,
    );
  }
}
