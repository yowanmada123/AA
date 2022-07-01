import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/payment/payment_list.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/home/onboarding.dart';
import 'package:boilerplate_flutter/page/payment/payment_detail.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form/form_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../profil/list_profil.dart';
import 'payment_controller.dart';

class PaymentOption extends StatefulWidget {
  const PaymentOption({Key? key}) : super(key: key);

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  final listPaymentMethods = <PaymentMethods>[].obs;
  final loading = true.obs;

  getData() async {
    loading.value = true;
    String options = '''
     
       query {
            userPaymentMethods {
              ... on UserPaymentMethod {
                name
                group
                howToPay
                id
                imageUrl
              }
              __typename
            }
            
          }

    ''';
    log(options.toString());
    Map<String, dynamic>? data = await GraphQLBase().query(options, showLoading: false);

    log(data.toString());
    var list = data!['userPaymentMethods'] as List;
    if (list.isNotEmpty) {
      List<PaymentMethods> newData = list.map((i) => PaymentMethods.fromMap(i)).toList();
      log(newData.length.toString());
      listPaymentMethods.value = newData;
      log(newData.toString());
    } else {
      listPaymentMethods.value = [];
    }

    log(listPaymentMethods.length.toString());

    loading.value = false;
  }

  final cGlobal = Get.find<GlobalController>();
  final cPayment = Get.put(PaymentController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OTitleHeader(
          title: "Page Title - Nunito Bold 14",
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("FIELD TITLE - NUNITO BOLD 12").fieldTitleText(),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: (loading.value)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: listPaymentMethods.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () async {
                                log("tap pay");
                                cGlobal.selectPaymentMethods.clear();
                                cGlobal.selectPaymentMethods.add(listPaymentMethods[index]);
                                String? transactioId = await cPayment.createpayment();
                                if (transactioId != null) {
                                  Get.offAll(HomePage());
                                  Get.to(PaymentDetailPage(
                                    transactionId: transactioId,
                                  ));
                                }
                              },
                              child: ItemPayment(
                                data: listPaymentMethods[index],
                              ),
                            );
                          }),
                ),
              ],
            ),
          ),
        ))
      ],
    );
  }
}

class ItemPayment extends StatelessWidget {
  final PaymentMethods data;
  const ItemPayment({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/sample/bca.png",
                // width: 40,
                height: 25,
              ),
            ),
            Expanded(child: Text(data.name).regularText()),
            Icon(Icons.arrow_right)
          ],
        ),
        Divider()
      ],
    );
  }
}
