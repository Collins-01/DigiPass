import 'package:flutter/material.dart';
// import 'package:flutter_nfc_kit_example/features/account/services/account_services.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/text_formating.dart';

class PageLayout extends StatefulWidget {
  PageLayout(
      {this.appBarDrawerEnabled = false,
      this.noAppBar = false,
      this.key,
      this.child,
      this.title,
      this.titleTextColor = textColor,
      this.fontSize = 16,
      this.backOnPressed,
      this.appBarActions,
      this.appBarColor = Colors.white,
      this.scaffoldColor = Colors.white,
      this.scaffoldPadding = 16.0,
      this.bottomNavEnabled = false,
      this.navPop = true,
      this.appBarElevation = 0.1});

  final appBarActions;
  final Color appBarColor;
  final bool appBarDrawerEnabled;
  final double appBarElevation;
  final Function? backOnPressed;
  final Widget? child;
  final double fontSize;
  final key;
  final bool bottomNavEnabled, navPop;
  final bool noAppBar;
  final Color scaffoldColor;
  final double? scaffoldPadding;
  final String? title;
  final Color? titleTextColor;

  @override
  _PageLayoutState createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },

      child: widget.noAppBar
          ? Scaffold(
              key: widget.key,
              body: SafeArea(
                child: _loading
                    ? const Text("")
                    : Container(
                        color: widget.scaffoldColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: widget.scaffoldPadding!),
                          child: widget.child,
                        ),
                      ),
              ),
            )
          : Scaffold(
              key: widget.key,
              body: SafeArea(
                child: Container(
                  color: widget.scaffoldColor,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          color: Colors.white,
                          height: 69.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                widget.navPop
                                    ? InkWell(
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Color(0xff003366),
                                          size: 24,
                                        ),
                                        onTap: () =>
                                            Navigator.of(context).pop(),
                                      )
                                    : const SizedBox(
                                        width: 0,
                                      ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Expanded(
                                    child: Row(
                                  children: [
                                    Text(
                                      '${widget.title}',
                                      style: textStyle(
                                        height: widget.fontSize / 24,
                                        fontSize: widget.fontSize,
                                        fontWeight: FontWeight.w500,
                                        color: widget.titleTextColor,
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: widget.appBarActions ?? [],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: widget.scaffoldPadding!),
                          child: _loading ? const Text("") : widget.child,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      // ),
    );
  }

  bool _loading = false;
}
