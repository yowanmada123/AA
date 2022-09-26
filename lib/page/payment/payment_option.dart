import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/payment/payment_methods.dart';
import 'package:boilerplate_flutter/model/tournament/create_data_tournamert.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/home/onboarding.dart';
import 'package:boilerplate_flutter/page/payment/payment_detail.dart';
import 'package:boilerplate_flutter/page/tournament/tournament_controller.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form/form_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../book_controller.dart';
import '../profil/list_profil.dart';
import 'payment_controller.dart';

class PaymentOption extends StatefulWidget {
  const PaymentOption({
    Key? key,
  }) : super(key: key);

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
  final booking = Get.find<BookController>();

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
                                booking.paymentMethods = listPaymentMethods[index];
                                // cGlobal.selectPaymentMethods.clear();
                                // cGlobal.selectPaymentMethods.add(listPaymentMethods[index]);
                                // log(listPaymentMethods[index].id);
                                // cTournament.tournamentdata.paymentMethod = listPaymentMethods[index].id;
                                // String? transactioId = await cPayment.createpayment();
                                // if (transactioId != null) {
                                // log(cTournament.tournamentdata.name.toString());
                                // log(cTournament.tournamentdata.drawSize.toString());
                                // log(cTournament.tournamentdata.tournamentFormat.toString());
                                // log(cTournament.tournamentdata.matchFormat.toString());
                                // log(cTournament.tournamentdata.product.toString());
                                // log(cTournament.tournamentdata.scheduleDate.toString());
                                // log(cTournament.tournamentdata.scheduleTime.toString());
                                // createTournament(cTournament);
                                //   Get.to(PaymentDetailPage(
                                //     transactionId: transactioId,
                                //   ));
                                // }
                                booking.submitBooking();
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

Future<void> createTournament(TournamentController cTournament) async {
  String option = '''
    mutation createTurnament{
      createTurnament(	
        input: {
          draw_size: $cTournament.tournamentdata.drawSize
          format: "$cTournament.tournamentdata.tournamentFormat"
          match: "$cTournament.tournamentdata.matchFormat"
          name: "$cTournament.tournamentdata.name"
          payment_method: "$cTournament.tournamentdata.paymentMethod"
          people: [
            {
              people_id: "1b83696a-8040-4450-abf0-d0523fb463f0"
            }
          ]
          phone_number: "08223544899774"
          product: [
            {
              product_id: "$cTournament.tournamentdata.product"
              scheduled_date: "$cTournament.tournamentdata.scheduleDate"
              scheduled_time: "$cTournament.tournamentdata.scheduleTime"
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
  try {
    Map<String, dynamic>? res = await GraphQLBase().mutate(option);
    if (res != null) {
      log(res.toString());
      final successMessage = res['createTurnament'][0]['Success'];
      log(successMessage);
      Get.offAll(const HomePage());
    }
  } on Error catch (e, s) {
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
