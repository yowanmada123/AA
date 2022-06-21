import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/main.dart';
import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/model/transaction/transaction_res.dart';
import 'package:boilerplate_flutter/page/booking/booking_info.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/appbar.dart';
import 'package:boilerplate_flutter/widget/base_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/list_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class TransactionListPage extends StatefulWidget {
  const TransactionListPage({Key? key}) : super(key: key);

  @override
  State<TransactionListPage> createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  final loading = true.obs;
  final listTransaction = <Transaction>[].obs;

  getData() async {
    String options = '''
      query listTransaction{
        transactions(filter: {}, paging: { limit: 10 }, sorting: []) {
          nodes {
            amount
            createdAt
            id
            payment_id
            payment_method
            phone_number
            product_id
            scheduled_date
            scheduled_time
            status
            updatedAt
          }
          pageInfo {
            hasNextPage
            hasPreviousPage
          }
        }
      }
    ''';
    Map<String, dynamic>? data = await GraphQLBase().query(options);
    var list = data!['transactions']['nodes'] as List;
    List<Transaction> newData = list.map((i) => Transaction.fromMap(i)).toList();
    log(newData.length.toString());
    listTransaction.value = newData;
    log(newData.toString());
    log(listTransaction.length.toString());
    loading.value = false;
  }

  final gstate = Get.find<GlobalController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "List Transaction",
      body: Column(
        children: [
          // Container(child: ItemTransaction(),)

          Expanded(
            child: Obx(
              () => Container(
                child: (loading.value)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: listTransaction.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemTransaction(
                            item: listTransaction[index],
                            // state: gstate,
                            // onTap: () {
                            //   // Get.to(ListHealtPage());
                            // },
                          );
                        }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// ItemTransaction
class ItemTransaction extends StatelessWidget {
  final Transaction item;
  // final GlobalController state;
  const ItemTransaction({Key? key, required this.item, 
  // required this.state
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110,
        // width: 150,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                // spreadRadius: 1,
                blurRadius: 0.1,
                offset: Offset(0, 1), // changes position of shadow
              )
            ],
        ),

        child: 
        Row(
          children: [
            Expanded(
              flex: 1,
              child: 
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(9),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          // spreadRadius: 1,
                          blurRadius: 0.1,
                          offset: Offset(0, 1), // changes position of shadow
                        )
                      ],
                  ),

                // child: Image(image: item.images),
            ),
              )),
            Expanded(
                flex: 2,
              child: Padding(
              padding: const EdgeInsets.only(top:8.0, bottom: 8.0, right: 8.0),
              child: Container(
                height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(9),
                      )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Transaction Name",
                        // item.name,
                        style:
                            TextStyle(color: Colors.black87),
                      ).titleText(),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          SvgPicture.asset("assets/ic/ic_location.svg"),
                          const Text(
                            "Transaction Address",
                            // item.address,
                            style:
                                TextStyle(color: Colors.blue),
                          ).regularText(),
                        ],
                      ),
                      const SizedBox(height: 15,),
                       const Text(
                        "Transaction Price",
                        // item.price,
                        style:
                            TextStyle(color: Colors.redAccent),
                      ).informationText(),
                    ],
                  ),
                ),
              ),
            )),

          ],
        ),
      ),
    );
  }
}
