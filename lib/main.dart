import 'package:boilerplate_flutter/all_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
//
const Color m3BaseColor = Color(0xff153676);

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
        brightness: useLightMode ? Brightness.light : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Boilerplate Flutter',
      theme: themeData,
      home: const AllScreen(),
    );
  }
}
