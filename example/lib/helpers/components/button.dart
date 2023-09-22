import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';

class AppButton extends StatefulWidget {
  final String? title;
  final VoidCallback? onPress;
  final bool loading;
  final double width;
  final double height;
  final Color color;
  final Color buttonTextColor;
  final Color borderColor;
  final bool allCaps, transparent;

  AppButton(
      {this.onPress,
      this.title,
      this.loading = false,
      this.width = 100.0,
      this.height = 56.0,
      this.color = primaryColor,
      this.borderColor = primaryColor,
      this.allCaps = true,
      this.transparent = false,
      this.buttonTextColor = Colors.white});

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: widget.loading ? null : widget.onPress,
          child: Container(
            width: widget.width == null ? width * 0.8 : widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                color: widget.color,

                // color: widget.loading ? Colors.grey : widget.color,
                border: Border.all(
                    width: 1.5,
                    color: widget.loading
                        ? Colors.transparent
                        : widget.borderColor),
                borderRadius: BorderRadius.circular(6)),
            child: TextButton(
              onPressed: null,
              child: widget.loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          width: 28.0,
                          height: 28.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.9,
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.title}",
                          style: textStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: widget.buttonTextColor,
                            height: 15 / 14,
                          ),
                        ),
                      ],
                    )),
            ),
          ),
        ),
      ],
    );
  }
}
