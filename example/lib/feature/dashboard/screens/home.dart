import 'dart:async';
import 'dart:io' show Platform, sleep;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_nfc_kit_example/helpers/components/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_nfc_kit_example/feature/clock-in/screens/clock-in.dart';
import 'package:flutter_nfc_kit_example/feature/dashboard/screens/result.dart';
import 'package:flutter_nfc_kit_example/feature/dashboard/screens/scan_screen.dart';
import 'package:flutter_nfc_kit_example/feature/dashboard/screens/widget/timer.dart';
import 'package:flutter_nfc_kit_example/feature/settings/screens/settings.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/components/app_icon.dart';
import 'package:flutter_nfc_kit_example/helpers/loaders.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/page_layout.dart';
import 'package:flutter_nfc_kit_example/helpers/values/sized_boxes.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: "",
      noAppBar:true,
     
      navPop: false,
      child: loading
          ? const Center(
              child: spinnerPry,
            )
          : ListView(
              physics:const PageScrollPhysics(),
              shrinkWrap: true,
              children: [
                kNormalHeight,
                Row(
                  children: [
                    SizedBox(width: 100.0, height: 50.0, child: AppIcon()),
                    Expanded(
                      child:Row(
                        mainAxisAlignment:MainAxisAlignment.end,
                        children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                });
                                Timer(Duration(seconds: 2), () {
                                  setState(() {
                                    loading = false;
                                  });
                                });
                              },
                              icon: Icon(Icons.refresh)),
                          IconButton(
                              onPressed: () async{
                                  final _pref = await SharedPreferences.getInstance();
                                  final token = _pref.getString("token");
                                nextPage(context, (context) => ProfileSettings(
                                  id:token,
                                ));
                              },
                              icon: const Icon(
                                Icons.account_circle,
                                color: primaryColor,
                                size: 30.0,
                              )),
                        ],
                      )
                    )
                  ],
                ),
                kNormalHeight,
                kNormalHeight,
                ListView(
                  shrinkWrap: true,
                  physics: const PageScrollPhysics(),
                  children: [
                    kNormalHeight,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 300.0,
                                child: InkWell(
                                    onDoubleTap: () {
                                      nextPage(
                                          context, (context) => ScanScreen());
                                    },
                                    child:
                                        SvgPicture.asset("assets/svg/1.svg")))
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text("Scan Card",
                        //         style: GoogleFonts.rubik(
                        //           fontSize: 22.0,
                        //           fontWeight: FontWeight.w500,
                        //           letterSpacing: 0.09,
                        //         )),
                        //   ],
                        // ),
                        PollingWidget(),
                        SizedBox(
                          height: 100.0,
                        ),
                      ],
                    ),
                  ],
                ),
                
              ],
            ),
    );
  }
}

class PollingWidget extends StatefulWidget {
  const PollingWidget({Key? key}) : super(key: key);

  @override
  State<PollingWidget> createState() => _PollingWidgetState();
}

class _PollingWidgetState extends State<PollingWidget> {
  String _platformVersion = '';
  NFCAvailability _availability = NFCAvailability.not_supported;
  NFCTag? _tag;
  String? _result, _writeResult;
  late TabController _tabController;
  List<ndef.NDEFRecord>? _records;

  bool loading = false;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb)
      _platformVersion =
          '${Platform.operatingSystem} ${Platform.operatingSystemVersion}';
    else
      _platformVersion = 'Web';
    initPlatformState();
    _records = [];
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    NFCAvailability availability;
    try {
      availability = await FlutterNfcKit.nfcAvailability;
    } on PlatformException {
      availability = NFCAvailability.not_supported;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
      _availability = availability;
    });
  }
  //

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: spinnerPry)
        : SingleChildScrollView(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                const SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                        color: primaryAccentColor,
                        borderRadius: BorderRadius.circular(5.0)),
                    padding: EdgeInsets.all(16),
                    // child: Text('Running on: $_platformVersion\nNFC: $_availability')
                    child: Text(
                        'NFC Status: ${_availability == 'NFCAvailability.not_supported' ? 'Disabled' : 'Enabled'}')
                ),
                const SizedBox(height: 10),

                AppButton(
                  onPress: () async {
                    try {
                      NFCTag tag = await FlutterNfcKit.poll();
                      setState(() {
                        _tag = tag;
                      });
                      await FlutterNfcKit.setIosAlertMessage(
                          "Working on it...");
                      if (tag.standard == "ISO 14443-4 (Type B)") {
                        String result1 =
                            await FlutterNfcKit.transceive("00B0950000");
                        String result2 = await FlutterNfcKit.transceive(
                            "00A4040009A00000000386980701");
                        setState(() {
                          _result = '1: $result1\n2: $result2\n';
                        });
                      } else if (tag.type == NFCTagType.iso18092) {
                        String result1 =
                            await FlutterNfcKit.transceive("060080080100");
                        setState(() {
                          _result = '1: $result1\n';
                        });
                      } else if (tag.type == NFCTagType.mifare_ultralight ||
                          tag.type == NFCTagType.mifare_classic ||
                          tag.type == NFCTagType.iso15693) {
                        var ndefRecords = await FlutterNfcKit.readNDEFRecords();
                        var ndefString = '';
                        for (int i = 0; i < ndefRecords.length; i++) {
                          ndefString += '${i + 1}: ${ndefRecords[i]}\n';
                        }
                        setState(() {
                          _result = ndefString;
                        });
                      } else if (tag.type == NFCTagType.webusb) {
                        var r = await FlutterNfcKit.transceive(
                            "00A4040006D27600012401");
                        print(r);
                      }
                    } catch (e) {
                      setState(() {
                        _result = 'error: $e';
                      });
                    }

                    // Pretend that we are working
                    if (!kIsWeb) sleep(new Duration(seconds: 1));
                    await FlutterNfcKit.finish(iosAlertMessage: "Finished!");
                    nextPage(
                        context,
                        (context) => Result(
                              cardId: _tag!.id,
                            ));
                  },
                  title: 'Scan card',
                  color: primaryColor,
                ),

                const SizedBox(height: 10),
               
              ])));
  }
}
