import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_nfc_kit_example/feature/dashboard/screens/dashboard.dart';
import 'package:flutter_nfc_kit_example/feature/onboarding/services/providers/AuthProvider.dart';
import 'package:flutter_nfc_kit_example/helpers/components/app_icon.dart';
import 'package:flutter_nfc_kit_example/helpers/error_widget.dart';
import 'package:flutter_nfc_kit_example/helpers/navigators.dart';
import 'package:flutter_nfc_kit_example/helpers/page_layout/page_layout.dart';

class ScreenLoader extends ConsumerStatefulWidget {
  const ScreenLoader({Key? key}) : super(key: key);

  @override
  ConsumerState<ScreenLoader> createState() => _ScreenLoaderState();
}

class _ScreenLoaderState extends ConsumerState<ScreenLoader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        Duration(seconds: 2),
        () => {
              nextPageNoPop(context, (context) => Dashboard()),
            });
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.white,
      child: ScreensLoaderChild(),
    );
  }
}

class ScreensLoaderChild extends StatelessWidget {
  const ScreensLoaderChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        noAppBar: true,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Expanded(child: Text("")),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [AppIcon()],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Center(child: SizedBox(width: 100.0, child: LinearLineLoader())),
          const Expanded(child: Text("")),
        ]));
  }
}

class LinearLineLoader extends StatefulWidget {
  @override
  State<LinearLineLoader> createState() => _LinearLineLoaderState();
}

/// AnimationControllers can be created with
/// vsync: this` because of TickerProviderStateMixin.
class _LinearLineLoaderState extends State<LinearLineLoader>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: controller.value,
      minHeight: 1.5,
      // semanticsLabel: 'Linear progress indicator',
    );
  }
}
