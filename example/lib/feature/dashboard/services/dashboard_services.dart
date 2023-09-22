// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_nfc_kit_example/helpers/snakbars.dart';

// class DashboradServices {
//   Dio myDio = Dio();

//   Future fetchRecentOrder(context) async {
//     final _pref = await SharedPreferences.getInstance();
//     final token = _pref.getString("token");
//     final id = _pref.getString("userId");
//     try {
//       Response response = await myDio.get(
//         '$baseUrl/shipping/${id}',
//         options: Options(headers: {"Authorization": 'Bearer $token'}),
//       );
//       print("the api respones");
//       // print(response.data[0]['_id']);
//       return response.data;
//     } on DioError catch (e) {
//       // print(e.response.data['message']);
//       defaultSnackyBar(context, "${e.response!.data['message'] ?? "An Error Ocurred"}",
//           "error");
//       //returnErrorMsg(e);
//       return null;
//     }
//   }
// }
