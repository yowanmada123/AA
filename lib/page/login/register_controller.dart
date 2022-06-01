import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/login/otp_email.dart';
import 'package:boilerplate_flutter/page/profil/list_profil.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RegisterController() {
    init();
  }
  init() {}

  String email = '';
  String password = '';
  final cGlobal = Get.find<GlobalController>();

  Future<void> signUpEmail() async {
    String q = '''
      mutation {
        register(
          input: {      
            email: "$email"
            password: "$password"
          }
        )   {
        __typename
        ... on Success
        {
          message
        }
      }
      }
    ''';
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(q);
      if (res != null) {
        Get.to(OtpEmailPage(
          email: email,
        ));
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> validasiEmail(String otp) async {
    String q = '''
      mutation {
            activateUserByOtp(
                input: {
                    email: "$email",
                    otp: "$otp"
                }
            ) {
                __typename
                ... on  AuthUserResponse{
                    token
                    user {
                        id
                        email
                        isActive   
                    }
                }
                ... on Error {
                    message
              
                }
                
            }
        }
    ''';
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(q);
      log(res.toString());
      if (res != null) {
        final token = res['activateUserByOtp'][0]['token'];
        log(token);
        cGlobal.setToken(token);
        Get.offAll(ListProfil());
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }
}
