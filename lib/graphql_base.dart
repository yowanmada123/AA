import 'dart:developer';

import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/widget/alertx.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

export 'package:graphql/client.dart';

class GraphQLBase {
  String? errorMessage;
  String errorMessageDefault = 'Something Wrong';

  final gstate = Get.find<GlobalController>();

  Future<GraphQLClient> getGraphQLClient() async {
    log(gstate.token);
    await checkToken();
    final Link _link = HttpLink(
      gstate.baseUrl,
      defaultHeaders: {
        'Authorization': gstate.token,
      },
      
    );

    return GraphQLClient(

      cache: GraphQLCache(),
      link: _link,
    );
  }

  Future<void> checkToken() async {
    if (gstate.token.isEmpty) return;
    if (JwtDecoder.isExpired(gstate.token)) {
      String q = '''
      query getRefreshToken {
        getRefreshedToken(oldToken:"${gstate.token}"){
          __typename
          ... on GetRefreshedTokenOK {
            token
          }
          ... on Error {
            status
            message
          }
        }
      }
      ''';
      GraphQLClient _client = GraphQLClient(
        cache: GraphQLCache(),
        link: HttpLink(gstate.baseUrl),
      );
      final QueryOptions options = QueryOptions(document: gql(q));
      final QueryResult result = await _client.query(options);
      if (result.data != null) {
        String newToken = result.data!['getRefreshedToken']['token'];
        gstate.setToken(newToken);
      }
    }
  }

  Future<Map<String, dynamic>?> query(String queryString,
      {Map<String, dynamic> variables = const {},
      bool showLoading = false}) async {
    final QueryOptions options =
        QueryOptions(document: gql(queryString), variables: variables);
    log('request query');
    // Show Loading
    if (showLoading) Alertx().loading();

    GraphQLClient _client = await getGraphQLClient();
    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      log('error query');
      log(result.exception.toString());
      if (result.exception!.linkException is ServerException) {
        ServerException exception =
            result.exception!.linkException as ServerException;
        errorMessage =
            exception.parsedResponse?.errors?[0].message ?? errorMessageDefault;

        // Alertx().error(errorMessage, code: 'UNAUTHENTICATED');
        // throw Exception(errorMessage);
      }
    } else {
      log(result.data.toString());
    }
    // Dismisse Loading
    if (showLoading) if (Get.isDialogOpen ?? false) Get.back();
    if (errorMessage != null) Alertx().error(errorMessage);
    return result.data;
  }

  Future<Map<String, dynamic>?> mutate(String queryString,
      {Map<String, dynamic> variables = const {},
      bool showLoading = true}) async {
    final MutationOptions options =
        MutationOptions(document: gql(queryString), variables: variables);
    log('request mutatation');
    // Show Loading
    if (showLoading) Alertx().loading();

    GraphQLClient _client = await getGraphQLClient();
    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      log('error mutation');
      log(result.exception.toString());
      try {
        errorMessage = result.exception!.graphqlErrors[0].message.toString();
      } catch (s) {}
    } else {
      log(result.data.toString());
      log(result.toString());
    }

    // Dismisse Loading
    if (showLoading) if (Get.isDialogOpen ?? false) Get.back();
    if (errorMessage != null) Alertx().error(errorMessage);
    return result.data;
  }
}
