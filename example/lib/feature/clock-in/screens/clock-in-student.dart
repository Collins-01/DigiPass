import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit_example/helpers/components/button.dart';
import 'package:flutter_nfc_kit_example/helpers/values/sized_boxes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/error_widget.dart';
import 'package:flutter_nfc_kit_example/helpers/loaders.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:flutter_nfc_kit_example/helpers/snakbars.dart';
import 'package:flutter_nfc_kit_example/helpers/util_helpers.dart';

class ClockInStudentWidsaw extends StatefulWidget {
  ClockInStudentWidsaw({Key? key, this.cardId}) : super(key: key);
  String? cardId;
  @override
  State<ClockInStudentWidsaw> createState() => _ClockInStudentWidsawState();
}

class _ClockInStudentWidsawState extends State<ClockInStudentWidsaw> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: firestore
              .collection("student-clock-in")
              .where('status', isEqualTo: true)
              .where('studentCard', isEqualTo: widget.cardId)
              .get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: spinnerPry,
              );
            }
            if (snapshot.hasError) {
              print("${snapshot.error}");
              return ErrorPageWidget();
            }
            if (snapshot.hasData) {
              final data = snapshot.data;
              print("history");
              print("-==-");
              print(data.docs);
              final history = data.docs ?? [];
              return history.length <= 0
                  ? Clocko(
                      cardId: widget.cardId,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svg/2.svg"),
                        kNormalHeight,
                        Center(
                          child: Text(
                              "This user is still clocked-in somewhere else"),
                        ),
                        kNormalHeight,
                        Center(
                          child: Container(
                              width: 100.0,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: AppButton(
                                onPress: () => Navigator.pop(context),
                                title: "Go back ",
                              )),
                        )
                      ],
                    );
            }
            return Text("");
          }),
    );
  }
}

class Clocko extends StatefulWidget {
  Clocko({Key? key, this.cardId}) : super(key: key);
  String? cardId;
  @override
  State<Clocko> createState() => _ClockoState();
}

class _ClockoState extends State<Clocko> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // title: "Clock In Student",
      // appBarElevation: 0.6,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Clock In Student",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: FutureBuilder(
            future: firestore.collection("clock-in-session").get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: spinnerPry,
                );
              }
              if (snapshot.hasError) {
                print("${snapshot.error}");
                return ErrorPageWidget();
              }

              if (snapshot.hasData) {
                final data = snapshot.data;
                print("history");
                print("-==-");
                print(data.docs);
                final history = data.docs ?? [];
                return history.length <= 0
                    ? Center(
                        child: Text("No session available"),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: history.length,
                        itemBuilder: (BuildContext context, i) {
                          final dataa = history[i].data();
                          return Column(
                            children: [
                              ListTile(
                                  // leading: Icon(Icons.book),
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text(
                                    "${dataa['room_title']}",
                                    style: textStyle(
                                      color: Color(0xff1a1a1a),
                                      fontSize: 16,
                                      height: 14 / 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: Container(
                                    height: 40,
                                    width: 88.0,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        action(context, history[i].id,
                                            dataa['room_title']);
                                      },
                                      child: Text(
                                        "Clock-in",
                                        style: textStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          height: 14 / 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )),
                              const Divider()
                            ],
                          );
                        });
              }

              return Text("");
            }),
      ),
    );
  }

  action(context, clockinSessionId, locName) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          return Container(
              height: 160,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Are you sure you want to clock this users in to this location?",
                          maxLines: 2,
                          style: textStyle(
                            fontSize: 14,
                            // height: 14 / 24,
                            height: 14 / 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: textStyle(color: primaryColor),
                          )),
                      SizedBox(
                        width: 10.0,
                      ),
                      ClockInButton(
                        cardId: widget.cardId,
                        sessionLocationId: clockinSessionId,
                        locName: locName,
                      )
                    ],
                  )
                ],
              ));
        });
  }
}

class ClockInButton extends StatefulWidget {
  ClockInButton({this.cardId, this.sessionLocationId, this.locName});
  String? cardId, sessionLocationId, locName;

  @override
  State<ClockInButton> createState() => _ClockInButtonState();
}

class _ClockInButtonState extends State<ClockInButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      width: 90.0,
      child: _loading
          ? Center(child: spinnerPry)
          : Container(
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  )),
              child: TextButton(
                  onPressed: () => createStudentClockIn(context),
                  child: Text(
                    "Yes",
                    style: textStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  )),
            ),
    );
  }

  bool _loading = false;

  createStudentClockIn(
    context,
  ) async {
    setState(() {
      _loading = true;
    });
    final _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("token");
    final data = {
      "invigilator": token,
      "studentCard": widget.cardId,
      "clockInSessionId": widget.sessionLocationId,
      "createdAt": DateTime.now(),
      "updatedAT": DateTime.now(),
      "status": true
    };
    final req = await firestore
        .collection("student-clock-in")
        .doc()
        .set(data)
        .whenComplete(() {
      defaultSnackyBar(
          context, "Student Clocked-in to ${widget.locName}", primaryColor);
      Navigator.pop(context);
      Navigator.pop(context);
    }).catchError((err) {
      setState(() {
        _loading = false;
      });
    });
  }
}
