import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/home/home_navbar.dart';
import 'package:boilerplate_flutter/page/login/otp_email.dart';
// import 'package:boilerplate_flutter/page/profil/list_profil.dart';
import 'package:boilerplate_flutter/page/home/home_page.dart';

import 'package:get/get.dart';

class RegisterController extends GetxController {
  RegisterController() {
    init();
  }
  init() {
    getTNC();
  }

  String email = '';
  String password = '';
  String tncContent = '';
  String tncVersion = '';
  String tncUpdatedAt = '';
  final cGlobal = Get.find<GlobalController>();

  Future<void> signUpEmail() async {
    String q = '''
      mutation {
      register(
        input: {
          email: "$email", 
          password: "$password" }){
        __typename
        
        ... on SuccessResponse{
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

        // Get.offAll(HomePage());
        Get.to(const HomePage());
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> getTNC() async {
    String q = '''
     query{
        tncs(filter:{
          isActive :  {is:true}
        }){
          id
          content
          version
          isActive
          updatedAt
        }
      }
    ''';
    try {
      Map<String, dynamic>? res = await GraphQLBase().query(q);
      log(res.toString());
      if (res != null) {
        tncContent = res['tncs'][0]['content'];
        tncVersion = res['tncs'][0]['version'];
        tncUpdatedAt = res['tncs'][0]['updatedAt'];
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> loginByEmail() async {
    String q = '''
     mutation {
      loginByEmail(
        input: {        
          email: "$email"
          password: "$password"
        }
      ) 
      {
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
        cGlobal.setId(res['loginByEmail'][0]['user']['id']);
        // if (res['loginByEmail'][0]['user']['profiles'].lenght > 0) {
        //   cGlobal.setFullName(
        //       res['loginByEmail'][0]['user']['profiles'][0]['fullname']);
        // }
        Get.offAll(HomeNavbarButton());
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> loginByGoogle(String token) async {
    String q = '''
    mutation {
      loginByGoogle(
        accessToken:"$token"
      ) {
        __typename
        ... on AuthUserResponse {
          token
        }
      }
    }
    ''';
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(q);
      if (res != null) {
        log(res.toString());
        final token = res['loginByGoogle'][0]['token'];
        log("token from login google $token");
        cGlobal.setToken(token);
        Get.offAll(HomePage());
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> loginByApple(
      {required final String identityToken,
      required final String authorizationCode}) async {
    String q = '''
   mutation {
      loginByApple(
        accessToken:"$identityToken"
        code:"$authorizationCode"
      ) {
        __typename
        ... on AuthUserResponse {
          token
        }
      }
    }

    ''';
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(q);
      if (res != null) {
        log(res.toString());
        final token = res['loginByApple'][0]['token'];
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
