import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/profil/list_profil.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController();

  final cGlobal = Get.find<GlobalController>();
  String email = '';
  String password = '';

  Future<void> loginByEmail() async {
    String q = '''
     mutation {
  loginByEmail(
    input: {        
      email: "$email"
      password: "$password"
    }
  ) {
    ... on AuthUserResponse {
      token
      user {
          id
        
          email
        __typename
      }
      __typename
    }
    ... on AuthUserResponse {
        user{
          id
          email
        }
      token
        
    }
   
    __typename
  }
}
    ''';
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(q);
      if (res != null) {
        log(res.toString());
        final token = res['loginByEmail'][0]['token'];
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
