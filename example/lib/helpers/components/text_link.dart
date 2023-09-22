import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';

class TextLink extends StatefulWidget {
  final String? title;

  TextLink({this.title = ""});
  @override
  _TextLinkState createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.title}',
              style: textStyle(
                color: Color(0xff00A568),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
