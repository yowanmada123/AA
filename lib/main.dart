import 'package:boilerplate_flutter/all_screen.dart';
import 'package:boilerplate_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'global_service.dart';

void main() {
  appInit();
}

appInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<GlobalService>(GlobalService());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

//
const Color m3BaseColor = Color(0xff153676);
// const Color m3BaseColor = Color.fromARGB(255, 60, 0, 255);

class _MyAppState extends State<MyApp> {
  bool useLightMode = true;
  late ThemeData themeData;
  @override
  initState() {
    super.initState();
    themeData = updateThemes(useLightMode);
  }

  ThemeData updateThemes(bool useLightMode) {
    return ThemeData(
        colorSchemeSeed: m3BaseColor,
        useMaterial3: true,
        brightness:
            GlobalService.to.isDark ? Brightness.dark : Brightness.light);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Boilerplate Flutter',
          theme: ThemeData(
              colorSchemeSeed: m3BaseColor,
              useMaterial3: true,
              brightness:
                  GlobalService.to.isDark ? Brightness.dark : Brightness.light),
          home: const AllScreen(),
        ));
  }
}
