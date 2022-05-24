import 'dart:developer';

import 'package:boilerplate_flutter/theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GlobalService extends GetxController {
  Future<GlobalService> init() async {
    return this;
  }

  static GlobalService get to => Get.find();

  final box = GetStorage();
  final _isDark = false.obs;
  get isDark => _isDark.value;
  void switchTheme() {
    _isDark.value = !_isDark.value;
    log(_isDark.value.toString());
    // Get.changeTheme(_isDark.value == true ? AppTheme.dark : AppTheme.light);
    // Get.changeTheme(AppTheme.dark);
    box.write('darkmode', !isDark);
  }
}
