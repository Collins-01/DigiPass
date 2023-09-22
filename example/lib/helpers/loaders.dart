import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:flutter_nfc_kit_example/welcome.dart';

const spinner = CircularProgressIndicator(
  color: Colors.white,
  strokeWidth: 2.0,
);

const spinnerPry = CircularProgressIndicator(
  color: primaryColor,
  strokeWidth: 2.0,
);

loadingDialog(context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 40.0,
            height: 40.0,
            child: spinner,
          ),
        );
      });
}

class Pageloader extends StatelessWidget {
  const Pageloader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(
            color: primaryColor,
            strokeWidth: 2.0,
          ),
        ],
      ),
    );
  }
}

futureLoadingModal(context) {
  showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 150,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5.0,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, size: 14.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 27.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Pageloader(),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Loading..., Please wait",
                          style: textStyle(color: textColor, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}



// drag to refresh block 
