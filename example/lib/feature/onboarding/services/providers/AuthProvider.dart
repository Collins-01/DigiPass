// // user details provider
// import 'package:flutter/cupertino.dart';
// ;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ibilemeds/features/account/services/account_services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final userProvider = FutureProvider.autoDispose((ref) async {
//   final req = await ref.read(dashboardProvider).getUserDetails2();
//   print("jackac=================");
//   print(req);
//   print("jackac=================");
//   return req ?? null;
// });

// final userNextOfKinProvider = FutureProvider.autoDispose((ref) async {
//   return ref.read(profileServicesProvider).getUserNextOfKin();
// });

// final userModelNotifier = StateNotifierProvider((ref) => User());

// class User extends StateNotifier {
//   User() : super(UserModel());

//   updateUser(UserModel user) {
//     state = user;
//   }

//   clearUser() {
//     state = UserModel();
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_nfc_kit_example/feature/onboarding/models/UserModel.dart';
import 'package:flutter_nfc_kit_example/feature/onboarding/services/auth_services.dart';

// final userNotifier = StateProvider<UserModel>((ref)=>UserModel()
//   ..id=""
//   ..email =""
//   ..firstName=""
//   ..lastName =""
//   ..phoneNumber=""
//   ..profilePhoto=""
//   ..role =""
//   ..verified = false
// );

final userFutureProvider = FutureProvider.autoDispose.family((ref, cntx) async {
  final req = await ref.read(authServicesProvider).fetchUserProfile(cntx);
  // print("jackac=================");
  // print(req);
  // print("jackac=================");
  return req ?? null;
});

// final userModelNotifier = StateNotifierProvider<UserModel>((ref) => User());
final userModelNotifier = StateNotifierProvider<User, dynamic>((ref) => User());

class User extends StateNotifier {
  User() : super(UserModel());

  updateUser(UserModel user) {
    state = user;
  }

  clearUser() {
    state = UserModel();
  }
}
