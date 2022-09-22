// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:boilerplate_flutter/model/product/product.dart';
import 'package:boilerplate_flutter/page/tournament/tournament_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/main.dart';
import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/model/tournament/create_data_tournamert.dart';
import 'package:boilerplate_flutter/page/booking/booking_controller.dart';
import 'package:boilerplate_flutter/page/booking/booking_info.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/maps/maps_open_street.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/appbar.dart';
import 'package:boilerplate_flutter/widget/base/button/button_small_outline.dart';
import 'package:boilerplate_flutter/widget/base/form/form_checkbox_filter.dart';
import 'package:boilerplate_flutter/widget/base/form/form_radio_filter.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';

class BookingListPage extends StatefulWidget {
  BookingListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  final loading = true.obs;
  final listPlace = <Place>[].obs;
  bool accept = false;
  final cBooking = Get.put(BookingController());
  getData() async {
    loading.value = true;
    String filterRegion = "";
    String priceFilter = "";
    if (cBooking.selectRegion.value.isNotEmpty) {
      filterRegion = '''
        region:{
                    name : 
                    {
                      iLike: "${cBooking.selectRegion.value}"
                    } 
                  }
        ''';
    }

    if (cBooking.priceMin.value != 0 && cBooking.priceMax.value != 0) {
      priceFilter = '''
 products:{
            price:{
              between:{
                lower: ${cBooking.priceMin.value}
                upper:${cBooking.priceMax.value}
              }
            }
          }
          ''';
    }
    String options = '''
      query {
        places(filter: {
          $filterRegion
          $priceFilter
        }, paging: { limit: 100 }, sorting: []) {
          pageInfo {
            hasNextPage
            hasPreviousPage
          }
          nodes {
           address
           region{
              id
              name
              type
            }
            id
            images
            latitude
            longitude
            name
          }
        }
      }
    ''';
    Map<String, dynamic>? data = await GraphQLBase().query(options);
    var list = data!['places']['nodes'] as List;
    List<Place> newData = list.map((i) => Place.fromMap(i)).toList();
    log(newData.length.toString());
    listPlace.value = newData;
    log(newData.toString());
    log(listPlace.length.toString());
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
      title: "List Place",
      backgroundColor: Color(redBooked),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                        Get.to(const ChoseLocation());
                      },
                    )),
              ],
            ),
          ),
          Obx(
            () => (Container(
              child: (cBooking.selectRegion.value.isNotEmpty || cBooking.priceMin.value != 0 || cBooking.priceMax.value != 0)
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          cBooking.selectRegion.value = "";
                          cBooking.priceMin.value = 0;
                          cBooking.priceMax.value = 0;
                        });
                        getData();
                      },
                      child: Row(
                        children: const [Text("Hapus Filter"), Icon(Icons.close)],
                      ))
                  : Container(),
            )),
          ),
          Expanded(
            child: Obx(
              () => Container(
                child: (loading.value)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: listPlace.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemPlace(
                            item: listPlace[index],
                            state: gstate,
                            // createData: widget.createData!,
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
                        ChoosePlaceButton(),
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
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7.0),
                                child: TextField(
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(fontSize: 12),
                                  textAlignVertical: TextAlignVertical.center,
                                  onChanged: (val) {
                                    cBooking.priceMin.value = int.parse(val);
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Min",
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
                              child: Padding(
                                padding: EdgeInsets.only(left: 7.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 12),
                                  textAlignVertical: TextAlignVertical.center,
                                  onChanged: (val) {
                                    cBooking.priceMin.value = int.parse(val);
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Max",
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
  // final CreateDataTournament? createData;
  final Place item;
  final GlobalController state;
  ItemPlace({
    Key? key,
    required this.item,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cGlobal = Get.find<GlobalController>();
    final ctournament = Get.put(TournamentController());
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
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      ).titleText(),
                      Text(item.region.name, style: TextStyle(color: OColorBrown)).informationText(),
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
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  cGlobal.selectPlace.clear();
                  cGlobal.selectPlace.add(item);
                  cGlobal.selectPlace.clear();
                  cGlobal.selectProduct.clear();
                  cGlobal.selectPaymentMethods.clear();
                  cGlobal.selectScheduleTime.clear();
                  Get.to(BookingInfo(
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
