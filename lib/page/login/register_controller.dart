import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  RegisterController();

  String email = '';
  String password = '';

  Future<void> signUpEmail() async {
    String q = '''
      mutation {
        register(
          input: {      
            email: "$email"
            password: "$password"
          }
        ) {
          ... on RegisterUserSuccess {
            registeredEmail
            message
            __typename
          }
          ... on CredentialsTakenError {      
            providedEmail
            message
            __typename
          }
          ... on InvalidInputError {
            errors {
              field
              messages
            }
            message
          }
          __typename
        }
      }
    ''';
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(q);
      if (res != null) {
        // Get.to(EmailSentPage());
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }
}
