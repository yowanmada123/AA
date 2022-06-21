import 'dart:developer';

import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:get/get.dart';

import '../../graphql_base.dart';

class PaymentController extends GetxController {
  final payment_method = "".obs;
  final phone_number = "".obs;
  final product_id = "".obs;
  final scheduled_date = "".obs;
  final scheduled_time = "".obs;
  PaymentController() {
    final cGlobal = Get.find<GlobalController>();
    log(cGlobal.selectPlace.toString());
    log(cGlobal.selectProduct.toString());
    log(cGlobal.selectScheduleTime.toString());
    log(cGlobal.selectPaymentMethods.toString());
    log(cGlobal.token.toString());
    payment_method.value = cGlobal.selectPaymentMethods.first.id;
    phone_number.value = "";
    product_id.value = cGlobal.selectProduct.first.id;
    scheduled_date.value = cGlobal.selectScheduleDate.value;
    scheduled_time.value = cGlobal.selectScheduleTime.first.schedule;
  }

  Future<String?> createpayment() async {
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
