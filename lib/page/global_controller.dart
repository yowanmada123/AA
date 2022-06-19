import 'dart:convert';
import 'dart:developer';

import 'package:boilerplate_flutter/model/payment/payment_list.dart';
import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/model/product/product.dart';
import 'package:boilerplate_flutter/model/product/schedule_time.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

const String mainBaseUrl = 'http://103.186.0.33:3000/graphql';
const String mainbaseFile = 'http://103.186.0.33:3000/uploads/place/';

class GlobalController extends GetxController {
  String baseUrl = mainBaseUrl;
  String baseFile = mainbaseFile;
  String token = '';
  String username = '';
  String profileImage = '';
  String idEdit = "3f89794e-f10d-497d-bd80-f7ab15bdd406";
  bool isDev = false;

  double latitude = 0.0;
  double longitude = 0.0;
  double widthFactor = 1;
  double maxWidth = double.infinity;
  double minWidth = 100;

  String addres = "";

  final box = GetStorage();

  //todo : select data transaksi
  final selectPlace = <Place>[].obs;
  final selectProduct = <Product>[].obs;
  final selectPaymentMethods = <PaymentMethods>[].obs;
  final selectScheduleDate = "".obs;
  final selectScheduleTime = <ScheduleTime>[].obs;

  void setPhoneNumber(String val) {
    box.write('PhoneNumber', val);
  }

  void checkISWeb() async {
    if (kIsWeb) {
      log("It's web");
      maxWidth = 600;
      minWidth = 350;
      widthFactor = 0.4;
    }
  }

  void setToken(String val) {
    final box = GetStorage();
    box.write('token', val);
    token = val;
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

  // void setData(UserLogin data) {
  //   final box = GetStorage();
  //   box.write('profileData', jsonEncode(data));
  // }

  // UserLogin getData() {
  //   final box = GetStorage();
  //   final UserLogin data =
  //       UserLogin.fromJson(jsonDecode(box.read('profileData')));
  //   log('profileData${box.read('profileData')}');
  //   return data;
  // }

  // Future<UserLogin> getDataEdit() async {
  //   final box = GetStorage();
  //   final UserLogin data =
  //       UserLogin.fromJson(jsonDecode(box.read('profileData')));
  //   log('profileData${box.read('profileData')}');
  //   return data;
  // }

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
