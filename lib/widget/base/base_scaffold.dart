import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BaseScaffold extends StatelessWidget {
  final Color backgroundColor;
  final Widget body;
  final Widget? bottomNavigationBar;
  final String? title;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const BaseScaffold(
      {this.title,
      required this.body,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.backgroundColor = Colors.white,
      this.bottomNavigationBar,
      this.actions});

  @override
  Widget build(BuildContext context) {
    // final gstate = Get.find<GlobalController>();

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: Text(
            title ?? '',
            style: TextStyle(fontSize: 14),
          ),
          elevation: 0,

          actions: actions,
          // toolbarHeight: gstate.toolbarHeight,
        ),
        body: SafeArea(child: Container(color: Colors.white, child: body)),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar);
  }
}