import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_nfc_kit_example/feature/dashboard/screens/dashboard.dart';
import 'package:flutter_nfc_kit_example/feature/onboarding/screens/sign_in.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/components/app_icon.dart';
import 'package:flutter_nfc_kit_example/helpers/components/button.dart';
import 'package:flutter_nfc_kit_example/helpers/components/email_input.dart';
import 'package:flutter_nfc_kit_example/helpers/components/input_field.dart';
import 'package:flutter_nfc_kit_example/helpers/components/telephone_input.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/page_layout.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:flutter_nfc_kit_example/helpers/snakbars.dart';
import 'package:flutter_nfc_kit_example/helpers/util_helpers.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _signUpFormkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _phoneNumeberController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();

  bool _showPassword = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        noAppBar: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AppIcon(
                        width: 107,
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text("Create your\naccount.",
                                style: textStyle(
                                  fontSize: 35.0,
                                  height: 38 / 35,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.09,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Form(
                          key: _signUpFormkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InputField(
                                title: "Username",
                                controller: _userNameController,
                                hintText: "John doe",
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              EmailInputField(
                                title: "Email Address",
                                controller: _emailController,
                                hintText: "Email Address",
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              TelephoneInput(
                                title: "Mobile Number",
                                controller: _phoneNumeberController,
                                hintText: "+234 9023687892",
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              InputField(
                                title: "Password",
                                passwordInput: _showPassword,
                                controller: _passWordController,
                                hintText: "Enter Password",
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  child: Container(
                                    width: 20.0,
                                    child: _showPassword
                                        ? Icon(
                                            Icons.visibility,
                                            color: Color(0xff808080),
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: Color(0xff808080),
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.13,
                              ),
                              AppButton(
                                loading: _loading,
                                onPress: () {
                                  if (_signUpFormkey.currentState!.validate()) {
                                    final data = {
                                      "phoneNumber":
                                          _phoneNumeberController.text.trim(),
                                      "password":
                                          _passWordController.text.trim()
                                    };
                                    signUpAction(context, data);
                                  }
                                },
                                title: "Create Account",
                              ),
                              const SizedBox(
                                height: 13.0,
                              ),
                              TextButton(
                                onPressed: () =>
                                    nextPage(context, (context) => SignIn()),
                                child: Text(
                                  "Login",
                                  style: textStyle(
                                      fontSize: 14,
                                      height: 15 / 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  signUpAction(context, data) async {
    // nextPage(context, (context) => Dashboard());
    final _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("token");
    setState(() {
      _loading = true;
    });

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passWordController.text.trim());
      setState(() {
        _loading = false;
      });
      print(credential.user!.uid);
      _pref.setString("token", credential.user!.uid);
      _pref.setString("email", credential.user!.email!);

      // defaultSnackyBar(context, "login successfull", successColor);
      // nextPageNoPop(context, (context) => Dashboard());
      final data = {
        "name": _userNameController.text.trim(),
        "email": _emailController.text.trim(),
        "phoneNumber": _phoneNumeberController.text.trim(),
        "userId": credential.user!.uid
      };
      addUser(context, data, credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _loading = false;
      });
      String err = "${e.message}";
      if (e.code == 'user-not-found') {
        err = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        err = 'Wrong password provided for that user.';
      }
      defaultSnackyBar(context, err, dangerColor);
      print(e);
    } catch (e) {
      // print(e);
      defaultSnackyBar(context, "An error occured", dangerColor);
      setState(() {
        _loading = false;
      });
    } // setState(() {
  }

  addUser(context, userData, uid) async {
    final req = await firestore
        .collection("users")
        .doc(uid)
        .set(userData)
        .whenComplete(() {
      defaultSnackyBar(context, "Sign up successfull.", successColor);
      Timer(
        Duration(seconds: 10),
        () => nextPageNoPop(context, (context) => Dashboard()),
      );
    }).catchError((err) {
      setState(() {
        _loading = false;
      });
    });
  }
}
