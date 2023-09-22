import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit_example/feature/clock-in/screens/clock-in.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/components/button.dart';
import 'package:flutter_nfc_kit_example/helpers/error_widget.dart';
import 'package:flutter_nfc_kit_example/helpers/loaders.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:flutter_nfc_kit_example/helpers/snakbars.dart';
import 'package:flutter_nfc_kit_example/helpers/util_helpers.dart';

class Result extends StatefulWidget {
  Result({Key? key, this.cardId}) : super(key: key);
  dynamic cardId;
  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // title: "Student Details",
      // titleTextColor: Color(0xff4d4d4d),
      // fontSize: 16,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Student Details",
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
            future: firestore
                .collection("registeredStudents")
                // .where('cardNumber', isEqualTo:"A9A63419")
                .where('cardNumber', isEqualTo: widget.cardId)
                .get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: spinnerPry,
                );
              }

              if (snapshot.hasError) {
                return ErrorPageWidget();
              }

              if (snapshot.hasData) {
                final data = snapshot.data;
                print("-===-");
                print("=-090e0iiiie");
                print("courses");
                print("-==-");
                // print(data.docs);
                final users = data.docs ?? [];

                print(users);
                // return Text("ds");
                if (users.length == 0) {
                  Navigator.pop(context);
                  defaultSnackyBar(
                      context, "Card not registered.", dangerColor);
                }
                return users.length == 0
                    ? Center(
                        child: Text("Card not registered."),
                      )
                    : ListView(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        shrinkWrap: true,
                        physics: const PageScrollPhysics(),
                        children: [
                          // Text("${widget.cardId}"),
                          SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50.0,
                                backgroundColor: Colors.grey,
                                backgroundImage: NetworkImage(
                                    "${users[0]['profilePic']}"
                                    // "https://portal.yabatech.edu.ng/portalplus/passport_db/HND(COMPUTERSCIENCE)FULLTIME20202021/FHD203210018.png"
                                    ),
                                child: Text(""),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text(
                              'Full Name',
                              style: textStyle(
                                fontSize: 14,
                                height: 14 / 18,
                                color: Color(0xff808080),
                              ),
                            ),
                            subtitle: Text(
                              "${users[0]['name']}",
                              style: textStyle(
                                fontSize: 16,
                                height: 16 / 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1a1a1a),
                              ),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text(
                              'Matric Number',
                              style: textStyle(
                                fontSize: 14,
                                height: 14 / 18,
                                color: Color(0xff808080),
                              ),
                            ),
                            subtitle: Text(
                              "${users[0]['matricNumber']}",
                              style: textStyle(
                                fontSize: 16,
                                height: 16 / 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1a1a1a),
                              ),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text(
                              'Department',
                              style: textStyle(
                                fontSize: 14,
                                height: 14 / 18,
                                color: Color(0xff808080),
                              ),
                            ),
                            subtitle: Text(
                              "${users[0]['department']}",
                              style: textStyle(
                                fontSize: 16,
                                height: 16 / 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1a1a1a),
                              ),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text(
                              'Level',
                              style: textStyle(
                                fontSize: 14,
                                height: 14 / 18,
                                color: Color(0xff808080),
                              ),
                            ),
                            subtitle: Text(
                              "${users[0]['level']}".toUpperCase(),
                              style: textStyle(
                                fontSize: 16,
                                height: 16 / 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1a1a1a),
                              ),
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            height: 16,
                          ),
                          ExpansionPanelList(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Courses",
                                style: textStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                  height: 16 / 17,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xff003366),
                                ),
                              )
                            ],
                          ),
                          FutureBuilder(
                              future: firestore
                                  .collection("clock-in-session")
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return Center(
                                    child: spinnerPry,
                                  );
                                }
                                if (snapshot.hasError) {
                                  return ErrorPageWidget();
                                }
                                final datat = snapshot.data;
                                final ls = datat.docs ?? [];
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: PageScrollPhysics(),
                                    itemCount: ls.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      final crs = ls[i];
                                      return ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    crs['room_title'],
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 2,
                                                    style: textStyle(
                                                      color: Color(0xff1a1a1a),
                                                      fontSize: 14,
                                                      height: 14 / 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )),
                                                ],
                                              ),
                                            ],
                                          ),
                                          trailing: Text(
                                            (crs['room_code'] as String)
                                                .toUpperCase(),
                                            style: textStyle(
                                              color: Color(0xff1a1a1a),
                                              fontSize: 14,
                                              height: 14 / 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ));
                                    });
                              }),

                          SizedBox(
                            height: 20.0,
                          ),
                          AppButton(
                            title: "Clock-in Student",
                            onPress: () => nextPage(
                                context,
                                (context) => ClockInPage(
                                      cardId: widget.cardId,
                                    )),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      );
              }
              return Text("");
            }),
      ),
    );
  }
}




// A9A63419 card number