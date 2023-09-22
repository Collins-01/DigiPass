import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/error_widget.dart';
import 'package:flutter_nfc_kit_example/helpers/loaders.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:flutter_nfc_kit_example/helpers/snakbars.dart';
import 'package:flutter_nfc_kit_example/helpers/util_helpers.dart';

class SessionHistory extends StatefulWidget {
  SessionHistory({Key? key, this.cardId}) : super(key: key);
  String? cardId;

  @override
  State<SessionHistory> createState() => _SessionHistoryState();
}

class _SessionHistoryState extends State<SessionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // title: "Clock-out",
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Clock-out",
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                    ? Center(
                        child: Text("No active session available"),
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
                                  // tileColor: Color(0xffe8f5e9),
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text("${dataa['studentCard']}"),
                                  trailing: Container(
                                    width: 88.0,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xff003366),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        // print(history[i].id);
                                        action(
                                          context,
                                          history[i].id,
                                        );
                                      },
                                      child: Text(
                                        "Clock-out",
                                        style: textStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
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

  action(context, clockOutSessionId) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          return Container(
              height: 150,
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
                          "Are you sure you want to clock this users out?",
                          maxLines: 2,
                          style: textStyle(fontSize: 14),
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
                      ClockOutButton(
                        cardId: widget.cardId,
                        sessionLocationId: clockOutSessionId,
                        docId: clockOutSessionId,
                      )
                    ],
                  )
                ],
              ));
        });
  }
}

class ClockOutButton extends StatefulWidget {
  ClockOutButton({this.cardId, this.sessionLocationId, this.docId});
  String? cardId, sessionLocationId, docId;

  @override
  State<ClockOutButton> createState() => _ClockOutButtonState();
}

class _ClockOutButtonState extends State<ClockOutButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      width: 90.0,
      child: _loading
          ? Center(child: spinnerPry)
          : Container(
              color: primaryColor,
              child: TextButton(
                  // onPressed:null,
                  onPressed: () => clockOut(context, widget.docId),
                  child: Text(
                    "Yes",
                    style: textStyle(color: Colors.grey),
                  )),
            ),
    );
  }

  bool _loading = false;

  clockOut(
    context,
    docId,
  ) async {
    setState(() {
      _loading = true;
    });
    final _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("token");
    final data = {"updatedAT": DateTime.now(), "status": false};
    final req = await firestore
        .collection("student-clock-in")
        .doc(docId)
        .update(data)
        .whenComplete(() {
      defaultSnackyBar(context, "Student Clocked-out ", primaryColor);
      Navigator.pop(context);
      Navigator.pop(context);
    }).catchError((err) {
      setState(() {
        _loading = false;
      });
    });
  }
}
