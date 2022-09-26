import 'dart:developer';

import 'package:boilerplate_flutter/model/payment/payment_list.dart';
import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/model/product/product.dart';
import 'package:boilerplate_flutter/model/product/schedule_time.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


const String mainBaseUrl = 'http://103.186.0.33:3003/graphql';
const String mainbaseFile = 'http://103.186.0.33:3003/uploads/';

class GlobalController extends GetxController {
  Future<GlobalController> init() async {
    return this;
  }

  static GlobalController get to => Get.find();

  final tabHomeIndex = 0.obs;
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

  String baseUrl = mainBaseUrl;
  String baseFile = mainbaseFile;
  String token = '';
  String username = '';
  String phone = '';
  String profileImage = '';
  String idEdit = "3f89794e-f10d-497d-bd80-f7ab15bdd406";
  bool isDev = false;

  double latitude = 0.0;
  double longitude = 0.0;

  String addres = "";

  //todo : select data transaksi
  final selectPlace = <Place>[].obs;
  final selectProduct = <Product>[].obs;
  final selectPaymentMethods = <PaymentMethods>[].obs;
  final selectScheduleDate = "".obs;
  final selectScheduleTime = <ScheduleTime>[].obs;

  void setToken(String val) {
    final box = GetStorage();
    box.write('token', val);
    token = val;
  }

  initState() {
    token = getToken() ?? '';
  }

  logout() {
    final box = GetStorage();
    box.remove("token");
  }

  String? getToken() {
    final box = GetStorage();
    String? token = box.read('token');
    return token;
  }

  void setUsername(String val) {
    final box = GetStorage();
    box.write('username', val);
    username = val;
  }

  void setProfileImage(String val) {
    final box = GetStorage();
    box.write('profileImage', val);
    profileImage = val;
  }

  String getUsername() {
    final box = GetStorage();
    return box.read('username');
  }

  String getProfileImage() {
    final box = GetStorage();
    log('profileImage');
    // log(box.read('profileImage'));
    String data = '';
    if (box.read('profileImage') != null) {
      data = box.read('profileImage');
    }
    log(data);
    return data;
  }
}
