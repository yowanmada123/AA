import 'dart:developer';

import 'package:boilerplate_flutter/all_screen.dart';
import 'package:boilerplate_flutter/model/user/profile.dart';
import 'package:boilerplate_flutter/page/booking/booking_list.dart';
import 'package:boilerplate_flutter/page/kyc/kyc_edit_form.dart';
import 'package:boilerplate_flutter/page/tournament/tournament_checkout_page.dart';
import 'package:boilerplate_flutter/page/place/place_list.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';
import 'package:boilerplate_flutter/widget/base/button/button_small_outline.dart';
import 'package:boilerplate_flutter/widget/base/form/form_checkbox.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/base/form/form_search_widget.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../graphql_base.dart';

class OrderListPage extends StatefulWidget {
  OrderListPage({Key? key}) : super(key: key);

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final loading = true.obs;
  final listProfile = <Profile>[].obs;
  String query = '';
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String q = '''
  query {
    profiles(filter: {}, paging: { limit: 10 }, sorting: []) {
      nodes {
        identityNumber
        identityType
        address
        createdAt
        dateOfBirth
        placeOfBirth
        email
        fullname
        gender
        id
        phone
        updatedAt
        identityPhoto
        profilePhoto
      }
      pageInfo {
        hasNextPage
        hasPreviousPage
      }
    }
  }

    ''';
    Map<String, dynamic>? data = await GraphQLBase().query(q);
    var list = data!['profiles']['nodes'] as List;
    List<Profile> newData = list.map((i) => Profile.fromMap(i)).toList();
    log(newData.length.toString());
    listProfile.value = newData;
    log(newData.toString());
    log(listProfile.length.toString());
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: OprimaryColor,
          title: const Text('Management Tournaments').white().pageTitleText(),
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'ONGOING',
              ),
              Tab(
                text: 'COMPLETED',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            /////////////////////ONGOING////////////////
            const Center(
              child: Text("It's rainy here"),
            ),
            /////////////////////COMPLETED////////////////
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Container(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OButtonSmallOutline(
                            title: "Filter",
                            titleColor: OColorBrown,
                            icon: "assets/ic/ic_filter.svg",
                            onTap: () {
                              // ShowFilter(context);
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
                                // SortBy(context);
                              },
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const ItemOrder(
                      isActive: true,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const ItemOrder(
                      isActive: false,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const ItemOrder(
                      isActive: false,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemOrder extends StatefulWidget {
  final bool isActive;
  const ItemOrder({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  State<ItemOrder> createState() => _ItemOrderState();
}

class _ItemOrderState extends State<ItemOrder> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 234,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 32,
            width: Get.width,
            decoration: BoxDecoration(
                color: (widget.isActive) ? const Color(statusDone) : const Color(statusExpired),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                )),
            child: Center(child: (widget.isActive) ? const Text("Active Tournaments").black().informationText() : const Text("Tournaments Finished ").black().informationText()),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(statusExpired),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset("assets/ic/ic_trophy_red.png")),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "TOURNAMENT NAME",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ).gray(),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text("TOURNAMENT A").black().regularText(),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "TOURNAMENT LOCATION",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ).gray(),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text("Lapangan Tenis Brata Bakti").black().regularText(),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "TOURNAMENT TYPE",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ).gray(),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text("Group").black().regularText(),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: BaseButton(
              height: 40,
              ontap: () {
                Get.to(() => const TournamentCheckoutPage());
              },
              text: (widget.isActive) ? "LIHAT DETAIL" : "CEK HASIL",
              color: OTextsecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
