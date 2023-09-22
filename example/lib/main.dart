import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_nfc_kit_example/feature/onboarding/services/auth_services.dart';
import 'package:flutter_nfc_kit_example/firebase_options.dart';
import 'package:flutter_nfc_kit_example/helpers/components/app_icon.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/page_layout.dart';
import 'package:flutter_nfc_kit_example/helpers/theme.dart';
import 'package:flutter_nfc_kit_example/screen_loader.dart';
import 'package:flutter_nfc_kit_example/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'nfcAppy',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: flutter_nfc_kit_exampleTheme.lightTheme,
      home: FutureBuilder(
          future: AuthServices().checkIfAuth(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return PageLayout(
                noAppBar: true,
                navPop: false,
                child: Container(
                    color: Colors.white, child: Center(child: AppIcon())),
              );
            }

            return snapshot.data["token"] != null
                ? ScreenLoader()
                // : SignIn();
                : Welcome();
          }),
    );
  }
}
