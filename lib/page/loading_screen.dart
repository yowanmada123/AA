import 'dart:developer';

import 'package:boilerplate_flutter/all_screen.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/profil/list_profil.dart';
import 'package:boilerplate_flutter/page/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final cGlobal = Get.find<GlobalController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
  }

  init() async {
    //todo load from box;
    await cGlobal.initState();
    if (cGlobal.token.isNotEmpty) {
      Get.offAll(WelcomingPage());
      // Get.offAll(HomePage());
    } else {
      Get.offAll(const WelcomingPage());
      // Get.offAll(const AllScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
