import 'package:dio/dio.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/snakbars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryStateServices {
  Dio myDio = Dio();
  final baseUrl = "https://countriesnow.space/api/v0.1";

  Future getCountryStates(context) async {
    final _pref = await SharedPreferences.getInstance();
    try {
      Response response = await myDio
          .post('$baseUrl/countries/states', data: {"country": "Nigeria"});

      return response;
    } on DioError catch (e) {
      print(e.message);
      // final errorMsg = e.response!.data;
      defaultSnackyBar(context, "An error occurred", secondaryPryDangerColor);
      return null;
    }
  }

  Future getStateCities(context, data) async {
    final _pref = await SharedPreferences.getInstance();
    try {
      Response response =
          await myDio.post('$baseUrl/countries/states', data: data);

      return response;
    } on DioError catch (e) {
      final errorMsg = e.response!.data;
      pageToast("${errorMsg['error']}", secondaryPryDangerColor);
      return null;
    }
  }
}
