import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit_example/feature/clock-in/screens/clock-in-student.dart';
import 'package:flutter_nfc_kit_example/feature/clock-in/screens/clock-out-student.dart';
import 'package:flutter_nfc_kit_example/feature/clock-in/screens/create_clockin.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';

class ClockInPage extends StatefulWidget {
  ClockInPage({Key? key, this.cardId}) : super(key: key);
  String? cardId;

  @override
  State<ClockInPage> createState() => _ClockInPageState();
}

class _ClockInPageState extends State<ClockInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // title: "Activites",
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Activities",
          style: textStyle(
            height: 16 / 24,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff4d4d4d),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Color(0xff003366),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 40.0,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     AppIcon(),
          //   ],
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(32.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text("Clock Students \nin&Out for exams auth",
          //           textAlign: TextAlign.center,
          //           style: GoogleFonts.rubik(
          //             fontSize: 22.0,
          //             fontWeight: FontWeight.w500,
          //             letterSpacing: 0.09,
          //           )),
          //     ],
          //   ),
          // ),
          Expanded(
            child: ListView(
              children: [
                // InkWell(
                //     onTap: () =>
                //         nextPage(context, (context) => CreateClockInSession()),
                //     child: ListTile(
                //       tileColor: primaryColor,
                //       title: Text(
                //         'Create Session',
                //         style: textStyle(
                //           color: primaryColor,
                //         ),
                //       ),
                //       trailing: Icon(Icons.chevron_right),
                //     )),
                // Divider(),
                // InkWell(
                //     onTap: () => nextPage(context, (context) => History()),
                //     child: ListTile(
                //       title: Text(
                //         'Clock-In/Out History',
                //         style: textStyle(
                //             color: primaryColor, fontWeight: FontWeight.w800),
                //       ),
                //       trailing: Icon(Icons.chevron_right),
                //     )),
                InkWell(
                    onTap: () =>
                        nextPage(context, (context) => CreateClockInSession()),
                    child: ListTile(
                      title: Text(
                        'Create Session',
                        style: textStyle(
                          color: Color(0xff1a1a1a),
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Color(0xff003366),
                      ),
                    )),
                Divider(),
                InkWell(
                    onTap: () => nextPage(
                        context,
                        (context) => ClockInStudentWidsaw(
                              cardId: widget.cardId,
                            )),
                    child: ListTile(
                      title: Text(
                        'Clock-in Student',
                        style: textStyle(
                          color: Color(0xff1a1a1a),
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Color(0xff003366),
                      ),
                    )),
                Divider(),
                InkWell(
                    onTap: () =>
                        nextPage(context, (context) => SessionHistory()),
                    child: ListTile(
                      title: Text(
                        'Clock-Out Student',
                        style: textStyle(
                          color: Color(0xff1a1a1a),
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Color(0xff003366),
                      ),
                    )),
                Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
