import 'dart:developer';
import 'dart:io';
import 'package:boilerplate_flutter/model/user/profile.dart';
import "package:http/http.dart";
import 'package:http_parser/http_parser.dart';

import '../graphql_base.dart';
import '../model/ocr_res.dart';

class ImageService {
  Future<Profile?> image(File file) async {
    String query = '''
      mutation uploadImages(\$file: ImageFile!) {
        uploadImages(file:  $file, 
          input: { 
            category: PLACE,
          }
        )
        {
          __typename
          
          ... on FilenameResponse {
            filename
          }
          ... on  Error{
            message
          }
          ... on ErrorResponse{
            message
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
      Profile item = Profile.fromMap(data!['filename'][0]);
      print(item);
      return item;
      log(data.toString());
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
  }
}
