import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/main.dart';
import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/page/booking/booking_info.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/maps/maps_open_street.dart';
import 'package:boilerplate_flutter/page/place/place_edit.dart';
import 'package:boilerplate_flutter/page/place/place_form.dart';
import 'package:boilerplate_flutter/page/region/region_list.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/alertx.dart';
import 'package:boilerplate_flutter/widget/base/appbar.dart';
import 'package:boilerplate_flutter/widget/base/button/button_choose_place.dart';
import 'package:boilerplate_flutter/widget/base/form/form_checkbox_filter.dart';
import 'package:boilerplate_flutter/widget/base/form/form_radio_filter.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PlaceListPage extends StatefulWidget {
  const PlaceListPage({Key? key}) : super(key: key);

  @override
  State<PlaceListPage> createState() => _PlaceListPageState();
}

class _PlaceListPageState extends State<PlaceListPage> {
  final loading = true.obs;
  final listPlace = <Place>[].obs;
  bool accept = false;
  late String placeValue = "Jakarta";

  getData() async {
    String options = '''
      query listPlaces{
        places(filter: {}, paging: { limit: 10 }, sorting: []) {
          nodes {
            address
            description
            distance
            id
            images
            latitude
            longitude
            name
            region {
              name
              id
              type
            }
          }
          pageInfo {
            hasNextPage
            hasPreviousPage
          }
        }
      }
    ''';
    // try {
      // bool isSuccess = false;
      log("OYOY");
      Map<String, dynamic>? data = await GraphQLBase().query(options);
      var list = data!['places']['nodes'] as List;
      log(list.toString());
      List<Place> newData = list.map((i) => Place.fromMap(i)).toList();
      log(newData.toString());
      listPlace.value = newData;
      log(newData.toString());
      log(listPlace.length.toString());
      loading.value = false;

    //   if (data!['places']['nodes'] != null) {
    //     isSuccess = true;
    //   } else {  
    //     Alertx().error("Error");
    //   }
    //   if (isSuccess) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Data Berhasil Ditampilkan ')),
    //     );
    //   }
    // } on Error catch (e, s) {
    //   print(e);
    //   print(s);
    // }

    // log(newData.length.toString());
    // log("OYOYOOYOYOYOY");
    // listPlace.value = newData;
    // log(newData.toString());
    // log(listPlace.length.toString());
    // loading.value = false;
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
      title: "List Place",
      backgroundColor: Color(redBooked),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => Container(
                child: (loading.value)
                    ? Container()
                    : ListView.builder(
                        itemCount: listPlace.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemPlace(
                            item: listPlace[index],
                            state: gstate,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(const PlaceFormPage()),
        child: const Icon(Icons.add),
        // child: Obx(() => Icon(GlobalController.to.isDark ? Icons.dark_mode : Icons.light_mode)),
      ),
    );
  }

  Future<dynamic> ShowFilter(BuildContext context) {
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
            height: 0.4 * MediaQuery.of(context).size.height,
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
                  const SizedBox(height: 47),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "LOCATION",
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                            ).titleText(),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ButtonChoosePlace(
                          placeValue: placeValue,
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegionListPage()),
                            );
                            if (result != null) {
                              setState(() {
                                placeValue = result.name;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "PRICE RANGE",
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                            ).titleText(),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 103,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Theme.of(context).colorScheme.outline, width: 0.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 7.0),
                                child: TextField(
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 12),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(30))),
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 7),
                            SvgPicture.asset("assets/ic/ic_strip.svg"),
                            const SizedBox(width: 7),
                            Container(
                              width: 103,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Theme.of(context).colorScheme.outline, width: 0.5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 7.0),
                                child: TextField(
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 12),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(30))),
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: OCheckBox(
                        text: "AVAILABLE TODAY",
                        accept: accept,
                        fungsi: (val) {
                          setState(() {
                            accept = !accept;
                            print(accept);
                          });
                        }),
                  ),
                ],
              ),
            ));
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

class ItemPlace extends StatelessWidget {
  final Place item;
  final GlobalController state;

  const ItemPlace({
    Key? key,
    required this.item,
    required this.state
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cGlobal = Get.find<GlobalController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            )),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ).titleText(),
                      ),
                      // Text(item.region.name, style: TextStyle(color: OColorBrown)).informationText(),
                      Expanded(child: Container()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: SvgPicture.asset("assets/ic/ic_location.svg"),
                          ),
                          Expanded(
                            child: Text(item.address).informationText(),
                          ),
                        ],
                      ),
                      // Text("Highlighted Text - Nunito Bold 14").pageTitleText(),
                    ],
                  ),
                )),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  cGlobal.selectPlace.clear();
                  // cGlobal.selectPlace.add(item);
                  cGlobal.selectPlace.clear();
                  cGlobal.selectProduct.clear();
                  cGlobal.selectPaymentMethods.clear();
                  cGlobal.selectScheduleTime.clear();
                  Get.to(UpdatePlacePage(
                    item: item,
                    
                  ));
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(9),
                    bottomRight: Radius.circular(9),
                  ),
                  child: Image.network(
                    state.baseFile + item.images.replaceAll("\"", ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
