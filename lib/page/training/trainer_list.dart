import 'dart:developer';

import 'package:boilerplate_flutter/model/user/trainer.dart';
import 'package:boilerplate_flutter/page/book_controller.dart';
import 'package:boilerplate_flutter/page/place/place_list.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';
import 'package:boilerplate_flutter/widget/base/button/button_small_outline.dart';
import 'package:boilerplate_flutter/widget/base/form/form.dart';
import 'package:boilerplate_flutter/widget/base/form/form_radio_filter.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/base/form/form_search_widget.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../graphql_base.dart';

class ListTrainerPage extends StatefulWidget {
  const ListTrainerPage({Key? key}) : super(key: key);

  @override
  State<ListTrainerPage> createState() => _ListTrainerPageState();
}

class _ListTrainerPageState extends State<ListTrainerPage> {
  final loading = true.obs;
  final listTrainers = <Trainers>[].obs;
  String query = '';

  final cBook = Get.find<BookController>();
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String q = '''
  query {
    Trainers(filter: {}, paging: { limit: 10 }, sorting: []) {
      nodes {
        createdAt
        id
        image_url
        name
        price
        updatedAt
      }
      pageInfo {
        hasNextPage
        hasPreviousPage
      }
    }
  }

    ''';
    Map<String, dynamic>? data = await GraphQLBase().query(q);
    var list = data!['Trainers']['nodes'] as List;
    List<Trainers> newData = list.map((i) => Trainers.fromMap(i)).toList();
    log(newData.length.toString());
    listTrainers.value = newData;
    log(newData.toString());
    log(listTrainers.length.toString());
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "Choose Trainer",
      body: Column(children: [
        Container(
          width: Get.width,
          // height: 70,
          child: OSearchWidget(
            text: query,
            hintText: 'Trainer   Name',
            onChanged: (String) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: OButtonSmallOutline(
                  title: "Filter",
                  titleColor: OColorBrown,
                  icon: "assets/ic/ic_filter.svg",
                  onTap: () {
                    ShowFilter(context).then((value) {
                      getData();
                    });
                  },
                ),
              ),
              Expanded(
                  flex: 1,
                  child: OButtonSmallOutline(
                    title: "Sort By",
                    titleColor: OColorBrown,
                    icon: "assets/ic/ic_sort.svg",
                    onTap: () {
                      SortBy(context);
                    },
                  )),
              Expanded(
                  flex: 1,
                  child: OButtonSmallOutline(
                    title: "Maps",
                    titleColor: OColorBrown,
                    icon: "assets/ic/ic_nav.svg",
                    onTap: () {
                      Get.to(PlaceListPage());
                    },
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        // GestureDetector(
        //   onTap: (){
        //     Get.to(DetailTrainerPage());
        //   },
        //   child: Column(
        //     children: [
        //       Row(
        //         children: [
        //           Image.asset("assets/images/trainer1.png",width: 120,
        //           height: 120,),
        //           Expanded(
        //             child: Column(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Row(
        //                         children: [
        //                           Container(
        //                             width: 8,
        //                             height: 8,
        //                             decoration: const BoxDecoration(
        //                               color: Colors.green,
        //                               shape: BoxShape.circle),
        //                           ),
        //                           const SizedBox(
        //                             width: 6,
        //                           ),
        //                           const Text("Tony Stark").descriptionText().black()
        //                         ],
        //                       ),
        //                       const Text("Dokter Umum").regularText().gray(),
        //                       Padding(
        //                         padding: const EdgeInsets.only(right: 16),
        //                         child: Row(
        //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             const Text("RS Medistra").regularText().gray(),
        //                             Container(
        //                               width: 80,
        //                               height: 32,
        //                               child: BaseButton(ontap: (){}, text: "PILIH", color: OTextsecondaryColor, textColor: Colors.white,))
        //                           ],
        //                         ),
        //                       ),
        //                       const SizedBox(
        //                         height: 14,
        //                       ),
        //                       const Text("Rp123.000").pageTitleText().black(),
        //                     ],
        //                   ),
        //                 ),

        //                 const Divider()
        //               ],
        //             ),
        //           ),

        //         ],
        //       ),

        //     ],
        //   ),
        // ),

        Obx(
          () => Container(
            child: (loading.value)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: SizedBox(
                      width: Get.width,
                      // height: Get.height,
                      child: ListView.builder(
                          itemCount: listTrainers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemTrainer(
                              item: listTrainers[index],
                              // onTap: () {
                              // Get.to(ListHealtPage());
                              // },
                            );
                          }),
                    ),
                  ),
          ),
        ),
      ]),
    );
  }

  Future<dynamic> ShowFilter(BuildContext context) {
    int trainingType = -1;
    List trainingOption = ['Free', 'Regular'];
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BaseButton(
                ontap: () {},
                text: "TERAPKAN",
                textColor: Colors.white,
                color: OTextsecondaryColor,
                outlineRadius: 0,
              ),
            ],
          ),
          Container(
              height: 0.6 * MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, right: 18.0, left: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset("assets/ic/ic_close.svg")),
                          const Text(
                            "Filter",
                            style: TextStyle(color: Color(0xff19204E)),
                          ).pageTitleText(),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset("assets/ic/ic_tick.svg")),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(
                                child: OFormText(
                              title: "MINIMUM PRICE",
                              titleColor: OprimaryColor,
                              hintText: "Rp",
                            )),
                            const SizedBox(width: 48),
                            Expanded(
                                child: OFormText(
                              title: "MAXIMUM PRICE",
                              titleColor: OprimaryColor,
                              hintText: "Rp",
                            )),
                          ]),
                          const SizedBox(height: 42),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "TRAINING TYPE",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: OprimaryColor),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                width: Get.width,
                                height: 46,
                                child: GridView.builder(
                                    shrinkWrap: false,
                                    scrollDirection: Axis.vertical,
                                    itemCount: trainingOption.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      crossAxisCount: 2,
                                      childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 8),
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // ontap of each card, set the defined int to the grid view index
                                            trainingType = index;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: trainingType == index ? OprimaryColor : Colors.white,
                                              border: Border.all(
                                                color: trainingType == index ? OprimaryColor : Colors.grey,
                                              ),
                                              borderRadius: BorderRadius.circular(8)),
                                          child: Expanded(
                                            child: Center(
                                              child: Text(
                                                trainingOption[index],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: trainingType == index ? Colors.white : Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 20.0),
                    //   child: OCheckBox(
                    //       text: "AVAILABLE TODAY",
                    //       accept: accept,
                    //       fungsi: (val) {
                    //         setState(() {
                    //           accept = !accept;
                    //           print(accept);
                    //         });
                    //       }),
                    // ),
                  ],
                ),
              )),
        ]);
      },
    );
  }

  Future<dynamic> SortBy(BuildContext context) {
    String? _groupValue;

    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return Container(
            height: 0.38 * MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18, top: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset("assets/ic/ic_close.svg")),
                        const Text(
                          "Sort By",
                          style: TextStyle(color: Color(0xff19204E)),
                        ).pageTitleText(),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset("assets/ic/ic_tick.svg")),
                      ],
                    ),
                  ),
                  const SizedBox(height: 47),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 37.0),
                    child: Column(
                      children: [
                        OMyRadioOption<String>(
                          value: 'A',
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value;
                            });
                          },
                          label: 'A',
                          text: 'POPULARITY',
                        ),
                        OMyRadioOption<String>(
                          value: 'B',
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value;
                            });
                          },
                          label: 'B',
                          text: 'CLOSEST DISTANCE',
                        ),
                        OMyRadioOption<String>(
                          value: 'C',
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value;
                            });
                          },
                          label: 'C',
                          text: 'PRICE: HIGH TO LOW',
                        ),
                        OMyRadioOption<String>(
                          value: 'D',
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value;
                            });
                          },
                          label: 'D',
                          text: 'PRICE: LOW TO HIGH',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class ItemTrainer extends StatefulWidget {
  final Trainers item;
  const ItemTrainer({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<ItemTrainer> createState() => _ItemTrainerState();
}

class _ItemTrainerState extends State<ItemTrainer> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    final cBook = Get.find<BookController>();
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                "assets/images/trainer1.png",
                width: 120,
                height: 120,
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(widget.item.name.toString()).descriptionText().black()
                            ],
                          ),
                          const Text("Sub title").regularText().gray(),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Diskripsi").regularText().gray(),
                                Container(
                                    width: 80,
                                    height: 32,
                                    child: BaseButton(
                                      ontap: () {
                                        // Get.to(DetailTrainerPage());
                                        cBook.selectTrainner.clear();
                                        cBook.selectTrainner.add(widget.item);
                                        Get.to(PlaceListPage());
                                      },
                                      text: "PILIH",
                                      color: OTextsecondaryColor,
                                      textColor: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(widget.item.price.toString()).pageTitleText().black(),
                        ],
                      ),
                    ),
                    const Divider()
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
