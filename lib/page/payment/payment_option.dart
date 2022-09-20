import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/payment/payment_list.dart';
import 'package:boilerplate_flutter/model/tournament/create_data_tournamert.dart';
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
  final CreateDataTournament? createData;
  const PaymentOption({Key? key, this.createData}) : super(key: key);

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
          title: "Pilih Metode Pembayaran",
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Transfer virtual account").fieldTitleText(),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: (loading.value)
                      ? const Center(
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
                                    createData: widget.createData,
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

Future<void> createTournament() async {
  String option = '''
    mutation createTurnament{
      createTurnament(	
        input: {
          draw_size: 1
          format: "Knockout"
          match: "Group"
          name: "TURKISH MATCH"
          payment_method: "BNI_QRIS"
          people: [
            {
              people_id: "1b83696a-8040-4450-abf0-d0523fb463f0"
            }
          ]
          phone_number: "08223544899774"
          product: [
            {
              product_id: "dd1da2cd-3d96-49cb-84f6-9035131bdf86"
              scheduled_date: "19/02/2022"
              scheduled_time: "18.00"
            }
          ]
        }
      ){
        __typename
        
        ... on Error{
          message
        }
        ... on ErrorResponse{
          message
        }
        ... on Success{
          message
        }
        ... on SuccessResponse{
          message
        }
        ... on InvalidInputError{
          message
        }
      }
    }
    ''';
    try{
            Map<String, dynamic>? res = await GraphQLBase().mutate(option);

    }on Error catch (e, s) {
      print(e);
      print(s);
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
            const Icon(Icons.arrow_right)
          ],
        ),
        const Divider()
      ],
    );
  }
}
