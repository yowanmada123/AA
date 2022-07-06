import 'dart:developer';
import 'dart:io';
import 'package:boilerplate_flutter/model/images_res.dart';
import 'package:boilerplate_flutter/model/user/profile.dart';
import "package:http/http.dart";
import 'package:http_parser/http_parser.dart';

import '../graphql_base.dart';
import '../model/ocr_res.dart';

class ImageService {
  Future<ImageRes?> image(File file) async {
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
      contentType: MediaType("image", "jpg"),
    );
    // print("ITEM NAME : $b");

    Map<String, dynamic> variables = {
      "file": b,
    };
    try {
      print("object");
      Map<String, dynamic>? data = await GraphQLBase().mutate(query, variables: variables);
      // log(" DATA ::: $data.toString()");
      // print("DATA $data");
      ImageRes item = ImageRes.fromMap(data!['uploadImages'][0]);
      // print("ITEM ITEM $data");
      return item;
      // log(data.toString());
    } on Error catch (e, s) {
      // print("HAHAHAHAHAHA");
      print(e);
      print(s);
    }
  }
}
