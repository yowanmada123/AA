import 'dart:developer';
import 'dart:io';
import 'package:boilerplate_flutter/model/user/profile.dart';
import "package:http/http.dart";
import 'package:http_parser/http_parser.dart';

import '../graphql_base.dart';
import '../model/ocr_res.dart';

class OcrPassportService {
  Future<Profile?> passport(File file) async {
    String query = '''
      mutation uploadPassport(\$file: ImageFile!) {
        uploadPassport(file: \$file){
          __typename,
          
          ... on Error{
            message
          }
          ... on  UploadPassportResponse{
            dateOfBirth
            fullname
            gender
            identityNumber
            nationality
          }
        }
      }
      ''';
    var b = await MultipartFile.fromPath(
      'imageProfil',
      file.path,
      contentType: MediaType("image", "jpeg"),
    );
    Map<String, dynamic> variables = {
      "file": b,
    };

    try {
      Map<String, dynamic>? data = await GraphQLBase().mutate(query, variables: variables);
      Profile item = Profile.fromMap(data!['uploadPassport'][0]);
      return item;
      log(data.toString());
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }
}
