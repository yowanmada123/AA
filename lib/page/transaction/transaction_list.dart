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
        height: 150,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            )),
        child: Row(
          children: [
            Expanded(
                // flex: 1,
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.payment_id,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ).titleText(),
                  Text(item.status, style: TextStyle(color: OColorBrown))
                      .informationText(),
                  Expanded(child: Container()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: SvgPicture.asset("assets/ic/ic_location.svg"),
                      ),
                      Expanded(
                        child: Text(item.phone_number).informationText(),
                      ),
                    ],
                  ),
                  // Text("Highlighted Text - Nunito Bold 14").pageTitleText(),
                ],
              ),
            )),
            // GestureDetector(
            //   onTap: () {
            //     Get.to(BookingInfo(
            //       item: item,
            //     ));
            //   },
            //   child: ClipRRect(
            //     borderRadius: const BorderRadius.only(
            //       topRight: Radius.circular(9),
            //       bottomRight: Radius.circular(9),
            //     ),
            //     child: Image.network(
            //       state.baseFile + item.images.replaceAll("\"", ""),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
