import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/profil/list_profil.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final cGlobal = Get.find<GlobalController>();

  Future<void> loginByGoogle(String token) async {
    String q = '''
    mutation{
        loginBySocialProvider(
          input:{
            accessToken:"$token"
            provider:GOOGLE
          }
          
        ){
          __typename
          ... on AuthUserResponse{
            token
          }
          
        }
      }
    ''';
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(q);
      if (res != null) {
        log(res.toString());
        final token = res['loginBySocialProvider'][0]['token'];
        log("token from login google $token");
        cGlobal.setToken(token);
        Get.offAll(HomePage());
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }
}
