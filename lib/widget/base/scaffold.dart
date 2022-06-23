import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OScaffold extends StatelessWidget {
  final Color backgroundColor;
  final Widget body;
  final Widget? bottomNavigationBar;
  final String? title;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const OScaffold({this.title, required this.body, this.floatingActionButton, this.floatingActionButtonLocation, this.backgroundColor = Colors.white, this.bottomNavigationBar, this.actions});

  @override
  Widget build(BuildContext context) {
    // final gstate = Get.find<GlobalController>();

    return Scaffold(
        backgroundColor: backgroundColor,
        // Theme.of(context).colorScheme.primaryContainer,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          centerTitle: true,
          title: Text(
            title ?? '',
          ).pageTitleText(),
          elevation: 0,
          actions: actions,
          // toolbarHeight: gstate.toolbarHeight,
        ),
        body: SafeArea(child: body),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar);
  }
}
