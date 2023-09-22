import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/page_layout.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
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
    return PageLayout(
      title: "Scan screen",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 300.0,
                  child: InkWell(
                      onTap: () {
                        // nextPage(context,(context)=>ClockInPage());
                      },
                      child: Stack(
                        children: [
                          // Image.asset("assets/dashboard/2.png"),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: SvgPicture.asset("assets/svg/2.svg")
                            ),
                          ),
                        ],
                      )))
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          Center(
            child: _tag != null
                ? Text(
                    'ID: ${_tag!.id}',
                    style: textStyle(
                        color: textColor,
                        fontSize: 26),
                  )
                // 'ID: ${_tag!.id}\nStandard: ${_tag!.standard}\nType: ${_tag!.type}\nATQA: ${_tag!.atqa}\nSAK: ${_tag!.sak}\nHistorical Bytes: ${_tag!.historicalBytes}\nProtocol Info: ${_tag!.protocolInfo}\nApplication Data: ${_tag!.applicationData}\nHigher Layer Response: ${_tag!.hiLayerResponse}\nManufacturer: ${_tag!.manufacturer}\nSystem Code: ${_tag!.systemCode}\nDSF ID: ${_tag!.dsfId}\nNDEF Available: ${_tag!.ndefAvailable}\nNDEF Type: ${_tag!.ndefType}\nNDEF Writable: ${_tag!.ndefWritable}\nNDEF Can Make Read Only: ${_tag!.ndefCanMakeReadOnly}\nNDEF Capacity: ${_tag!.ndefCapacity}\n\n Transceive Result:\n$_result')
                : Text('No tag polled yet.',
                    style: textStyle(
                        color: textColor,
                        fontSize: 26)),
          ),
          SizedBox(
            height: 50.0,
          ),
          SizedBox(
            height: 40.0,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  NFCTag tag = await FlutterNfcKit.poll();
                  setState(() {
                    _tag = tag;
                  });
                  await FlutterNfcKit.setIosAlertMessage("Working on it...");
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
              },
              child: Text('Scan card'),
            ),
          )
        ],
      ),
    );
  }
}
