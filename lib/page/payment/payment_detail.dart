import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/payment/payment_controller.dart';
import 'package:boilerplate_flutter/widget/base/scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class PaymentDetailPage extends StatefulWidget {
  final String transactionId;
  const PaymentDetailPage({Key? key, required this.transactionId}) : super(key: key);

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  @override
  Widget build(BuildContext context) {
    final cGlobal = Get.find<GlobalController>();

    return OScaffold(
      title: "Detail Pembayaran",
      body: GetBuilder<PaymentController>(
          init: PaymentController(),
          initState: (_) {},
          builder: (c) {
            return Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.brown,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.info_rounded),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Information Text - Nunito Regular 12").regularText(),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [Text("Highlighted Text - ").titleText(), Expanded(child: Text("Nunito Bold 14 ").titleText().red())],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Pembayaran").fieldTitleText().brown(),
                          Text(cGlobal.selectPaymentMethods.first.name).regularBigText(),
                          SizedBox(
                            height: 20,
                          ),
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
                              Expanded(flex: 1, child: Text(c.phone_number.value).titleText()),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "INTERACTIVE TEXT - Nunito Bold 12",
                                    textAlign: TextAlign.end,
                                  ).fieldTitleText())
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Venue Booking").fieldTitleText().brown(),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cGlobal.selectProduct.first.name,
                                      ).titleText(),
                                      // Text(
                                      //   cGlobal.selectProduct.first.name,
                                      // ).regularBigText()
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    cGlobal.selectProduct.first.price.toCurrency(),
                                    textAlign: TextAlign.end,
                                  ).regularBigText()),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Processing Fee",
                                  ).regularBigText()),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "-",
                                    textAlign: TextAlign.end,
                                  ).regularBigText()),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Total",
                                  ).regularBigText()),
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    cGlobal.selectProduct.first.price.toCurrency(),
                                    textAlign: TextAlign.end,
                                  ).titleText()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 12,
                      color: Colors.grey[300],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text("FIELD TITLE - NUNITO BOLD 12 ").fieldTitleText().brown(), _buildPanel()],
                      ),
                    )
                  ],
                ));
          }),
    );
  }

  final List<Item> _data = generateItems(8);
  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue).fieldTitleText(),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue).descriptionText(),
              // subtitle:
              //     const Text('To delete this panel, tap the trash can icon')
              //         .descriptionText(),
              // // trailing: const Icon(Icons.delete),
              onTap: () {}),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}
