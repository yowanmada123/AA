import 'package:boilerplate_flutter/all_screen.dart';
import 'package:boilerplate_flutter/lib_color_schemes.g.dart';
import 'package:boilerplate_flutter/page/booking/booking_list.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/maps/maps_open_street.dart';
import 'package:boilerplate_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'global_service.dart';

void main() {
  appInit();
}

appInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<GlobalService>(GlobalService());
  await GetStorage.init();
  final gstate = Get.put(GlobalController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

//
const Color m3BaseColor = Color.fromARGB(255, 255, 0, 0);
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
            //TODO : AUTO THEME
            colorSchemeSeed: m3BaseColor,
            // appBarTheme: AppBarTheme(backgroundColor: m3BaseColor),
            useMaterial3: true,
            //TODO : CUSTOM THEME
            // colorScheme: GlobalService.to.isDark ? darkColorScheme: lightColorScheme,
            brightness:
                GlobalService.to.isDark ? Brightness.dark : Brightness.light,
            textTheme: GoogleFonts.nunitoTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: const AllScreen(),
        ));
  }
}
