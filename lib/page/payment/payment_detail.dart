import 'package:boilerplate_flutter/widget/base_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PaymentDetailPage extends StatefulWidget {
  const PaymentDetailPage({Key? key}) : super(key: key);

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "Page Title",
      body: Container(
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
                                  Text("Information Text - Nunito Regular 12")
                                      .regularText(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text("Highlighted Text - ").titleText(),
                                      Expanded(
                                          child: Text("Nunito Bold 14 ")
                                              .titleText()
                                              .red())
                                    ],
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
                    Text("FIELD TITLE - NUNITO BOLD 12 ")
                        .fieldTitleText()
                        .brown(),
                    Text("FIELD TITLE - NUNITO BOLD 12 ").regularBigText(),
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
                        Expanded(
                            flex: 1,
                            child: Text("Field Text - Nunito Regular 14")
                                .titleText()),
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
                    Text("FIELD TITLE - NUNITO BOLD 12 ")
                        .fieldTitleText()
                        .brown(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text("Field Text - Nunito Bold 14").titleText(),
                                Text(
                                  "FIELD TITLE - NUNITO Regular 14 ",
                                ).regularBigText()
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "FIELD TITLE - NUNITO regular 14 ",
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
                              "FIELD TITLE - NUNITO regular 14 ",
                            ).regularBigText()),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "FIELD TITLE - NUNITO regular 14 ",
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
                              "FIELD TITLE - NUNITO Regular 14 ",
                            ).regularBigText()),
                        Expanded(
                            flex: 1,
                            child: Text(
                              "FIELD TITLE - NUNITO Bold 14 ",
                              textAlign: TextAlign.end,
                            ).titleText()),
                      ],
                    ),
                    Divider(),
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
                  children: [
                    Text("FIELD TITLE - NUNITO BOLD 12 ")
                        .fieldTitleText()
                        .brown(),
                    _buildPanel()
                  ],
                ),
              )
            ],
          )),
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
