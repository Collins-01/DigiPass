import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit_example/helpers/error_widget.dart';
import 'package:flutter_nfc_kit_example/helpers/loaders.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/page_layout.dart';
import 'package:flutter_nfc_kit_example/helpers/util_helpers.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, this.data}) : super(key: key);
  final dynamic data;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: "Profile",
      child: ListView(
        shrinkWrap: true,
        physics: PageScrollPhysics(),
        children: [
          ListTile(
            title:Text("Name"),
            subtitle:Text(widget.data['name']),
          ),
          Divider(),
          ListTile(
            title:Text("Email"),
            subtitle:Text(widget.data['email']),
          ),
          Divider(),
          ListTile(
            title:Text("Phone"),
            subtitle:Text(widget.data['phoneNumber']),
          ),
          Divider(),


        ],
      )
    );
  }
}
