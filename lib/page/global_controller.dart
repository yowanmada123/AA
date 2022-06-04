import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GlobalController extends GetxController {
  String baseUrl = 'http://103.186.0.33:3000/graphql';
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

  // var dataUser = User(
  //     id: 0,
  //     name: '',
  //     passwordInput: '',
  //     emailInput: '',
  //     error: '',
  //     otp_histories: []).obs;

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
