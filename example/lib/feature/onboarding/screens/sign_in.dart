import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_nfc_kit_example/feature/dashboard/screens/dashboard.dart';
import 'package:flutter_nfc_kit_example/feature/dashboard/screens/home.dart';
import 'package:flutter_nfc_kit_example/feature/onboarding/screens/sign_up.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/components/app_icon.dart';
import 'package:flutter_nfc_kit_example/helpers/components/button.dart';
import 'package:flutter_nfc_kit_example/helpers/components/input_field.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/page_layout.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';
import 'package:flutter_nfc_kit_example/helpers/snakbars.dart';

import 'dart:io' show Platform;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _signInFormkey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
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
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: AppIcon(
                    width: 107,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 120.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Login to your\naccount.",
                              style: textStyle(
                                fontSize: 35.0,
                                height: 38 / 35,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.09,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Form(
                          key: _signInFormkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InputField(
                                title: "Email",
                                controller: _emailController,
                                hintText: "Email address",
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              InputField(
                                title: "Password",
                                passwordInput: _showPassword,
                                controller: _passWordController,
                                hintText: "Password",
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
                              const SizedBox(
                                height: 16.0,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Forgot Password?",
                                    style: textStyle(
                                      fontSize: 14,
                                      height: 15 / 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 64,
                              ),
                              AppButton(
                                loading: _loading,
                                onPress: () {
                                  if (_signInFormkey.currentState!.validate()) {
                                    final data = {
                                      "phoneNumber":
                                          _emailController.text.trim(),
                                      "password":
                                          _passWordController.text.trim()
                                    };

                                    if (Platform.isIOS) {
                                      nextPage(
                                          context, (context) => Dashboard());
                                    }
                                    signInAction(context);
                                  }
                                },
                                title: "Login",
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              TextButton(
                                onPressed: () =>
                                    nextPage(context, (context) => SignUp()),
                                child: Text(
                                  "Create account",
                                  style: textStyle(
                                    color: primaryColor,
                                    fontSize: 14,
                                    height: 15 / 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 60.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  signInAction(context) async {
    final _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("token");
    setState(() {
      _loading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passWordController.text.trim());
      nextPage(context, (context) => Home());

      print(credential.user!.uid);
      _pref.setString("token", credential.user!.uid);
      _pref.setString("email", credential.user!.email!);

      defaultSnackyBar(context, "login successfull", successColor);
      setState(() {
        _loading = false;
      });
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
      print('error');
      print(e);
    } catch (e) {
      // print('error');
      // print(e);
      defaultSnackyBar(context, "An error occured", dangerColor);
      setState(() {
        _loading = false;
      });
    }
  }
}
