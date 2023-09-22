import 'package:flutter_nfc_kit_example/feature/onboarding/screens/sign_in.dart';
import 'package:flutter_nfc_kit_example/feature/onboarding/services/auth_services.dart';
import 'package:flutter_nfc_kit_example/feature/settings/screens/profile.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/error_widget.dart';
import 'package:flutter_nfc_kit_example/helpers/loaders.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/page_layout.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit_example/helpers/snakbars.dart';

import 'package:flutter_nfc_kit_example/helpers/util_helpers.dart';
import 'package:flutter_nfc_kit_example/helpers/values/sized_boxes.dart';

class ProfileSettings extends StatelessWidget {
  ProfileSettings({this.id});

  final String? id;
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: "Account ",
      scaffoldPadding:0,
      child: FutureBuilder(
          future: firestore.collection("users").doc(id).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: spinnerPry,
              );
            }
            if (snapshot.hasError) {
              return ErrorPageWidget();
            }

            final data = snapshot.data;
            pageToast(id, primaryColor);
            final user = data.data();

            return ListView(
              shrinkWrap: true,
              physics: const PageScrollPhysics(),
              children: [
                kNormalHeight,
                ListTile(
                  title:Center(
                    child:CircleAvatar(
                      radius:35,
                      backgroundColor:primaryColor,
                      child:Icon(Icons.account_circle,size:30.0,),
                    ),
                  ),
                  subtitle:Column(
                    children: [
                      kNormalHeight,
                      Text(user['name'] ?? 'dscdscds',
                      textAlign:TextAlign.center,
                      style:textStyle(
                        fontWeight:FontWeight.w800,
                        fontSize:20.0
                      )),
                    ],
                  ),
                ),
                Divider(
                  height:20.0,
                  thickness:10,
                ),
                InkWell(
                  onTap:(){
                    nextPage(context,(context)=>Profile(
                      data:user
                    ));
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal:16.0),
                    title: Text("Profile"),
                  ),
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal:16.0),
                  title: Text("Change password"),
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Log out"),
                            content: Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    "Cancel",
                                    style: textStyle(color: Colors.grey),
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    final req = await AuthServices()
                                        .logoutUser(context)
                                        .then((value) => nextPageNoPop(
                                            context, (context) => SignIn()));
                                  },
                                  child: Text(
                                    "Proceed",
                                  )),
                            ],
                          );
                        });
                  },
                  child: const ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal:16.0),
                    title: Text("Sign out"),
                  ),
                ),
                Divider()
              ],
            );
          }),
    );
  }
}
