import 'dart:developer';

import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/tournament/tournament_controller.dart';
import 'package:get/get.dart';

import '../../graphql_base.dart';

class PaymentController extends GetxController {
  final cGlobal = Get.find<GlobalController>();
  
  Future<String?> createpayment() async {
    String payment_method = cGlobal.selectPaymentMethods.first.id;
    String phone_number = "";
    String? product_id = cGlobal.selectProduct.first.id;
    String scheduled_date = cGlobal.selectScheduleDate.value;
    String scheduled_time = cGlobal.selectScheduleTime.first.schedule;

    String data = '''
              mutation {
                createTransaction(
                  input: {
                    payment_method: "$payment_method"
                    phone_number: "085259737334"
                    product_id: "$product_id"
                    scheduled_date: "$scheduled_date"
                    scheduled_time: "$scheduled_time"
                  }
                ) {
                  __typename
                 ... on Error{
                    message
                  }
                  ... on  SuccessCreateTransaction{
                    transactionId
                  }
                  ... on InvalidInputError{
                    message
                  }
                }
              }

''';
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(data);
      if (res != null) {
        return res["createTransaction"][0]["transactionId"];
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }
}
