import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/page/profil/list_profil.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController();

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
    ... on UserNotFoundError {
        message
        providedEmail
    }
    ... on UserNotActivatedError {
        message
        providedEmail
    }
    ... on InvalidCredentialsByEmailError {
        providedEmail
        message
        __typename
    }
    __typename
  }
}
    ''';
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(q);
      if (res != null) {
        
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }
}
