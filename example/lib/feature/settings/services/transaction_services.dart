import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_nfc_kit_example/feature/dashboard/screens/dashboard.dart';
import 'package:flutter_nfc_kit_example/feature/onboarding/screens/sign_in.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/keys.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/snakbars.dart';
import 'package:flutter_nfc_kit_example/helpers/util_helpers.dart';

final transactionServicesProvider =
    Provider<TransactionServices>((ref) => TransactionServices());

class TransactionServices {
  Dio myDio = Dio();
  String baseUrl = ConstantKey.BASE_URL_LIVE;

  Future transfer(context, data) async {
    final _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("token");
    final id = _pref.getString("userId");
    try {
      Response response = await myDio.post(
        '$baseUrl/accounts/transfer',
        data: data,
        options: Options(headers: {"Authorization": 'Bearer $token'}),
      );
      print("the api respones");
      print(response);
      final res = response.data['message'];
      defaultSnackyBar(context, "$res", primaryColor);

      return response;
    } on DioError catch (e) {
      // print(e.response.data['message']);
      print("printing error = ${e}");
      // snackyBar(context(e.response.data['message'] ?? "An Error Ocurred", dangerColor);
      //returnErrorMsg(e);
      return null;
    }
  }

  Future withdraw(context, data) async {
    final _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("token");
    final id = _pref.getString("userId");
    try {
      Response response = await myDio.post(
        '$baseUrl/accounts/withdraw',
        data: data,
        options: Options(headers: {"Authorization": 'Bearer $token'}),
      );
      print("the api respones");
      print(response);
      final res = response.data['message'];
      defaultSnackyBar(context, "$res", primaryColor);

      return response;
    } on DioError catch (e) {
      // print(e.response.data['message']);
      print("printing error = ${e}");
      // snackyBar(context(e.response.data['message'] ?? "An Error Ocurred", dangerColor);
      //returnErrorMsg(e);
      return null;
    }
  }

  Future getTransaction(context) async {
    final _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("token");
    final id = _pref.getString("userId");
    try {
      Response response = await myDio.get(
        '$baseUrl/transactions',
        options: Options(headers: {"Authorization": 'Bearer $token'}),
      );
      print("the api respones");
      print(response);
      // final res = response.data['message'];
      // defaultSnackyBar(context, "$res", primaryColor);

      return response.data;
    } on DioError catch (e) {
      // print(e.response.data['message']);
      print("printing error = ${e}");
      // snackyBar(context(e.response.data['message'] ?? "An Error Ocurred", dangerColor);
      //returnErrorMsg(e);
      return null;
    }
  }
}
