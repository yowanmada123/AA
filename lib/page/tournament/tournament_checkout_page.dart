import 'dart:developer';

import 'package:boilerplate_flutter/all_screen.dart';
import 'package:boilerplate_flutter/model/user/profile.dart';
import 'package:boilerplate_flutter/page/booking/booking_list.dart';
import 'package:boilerplate_flutter/page/kyc/kyc_edit_form.dart';
import 'package:boilerplate_flutter/page/payment/payment_option.dart';
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
import '../../widget/base/form/form.dart';
import '../../widget/popup/bottom_sheet.dart';

class TournamentCheckoutPage extends StatefulWidget {
  const TournamentCheckoutPage({Key? key}) : super(key: key);

  @override
  State<TournamentCheckoutPage> createState() => _TournamentCheckoutPageState();
}

class _TournamentCheckoutPageState extends State<TournamentCheckoutPage> {
  final _tournamentNameController = TextEditingController(text: '');
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
    return OScaffold(
      title: "Tournament Details",
      body: SafeArea(
        child: Stack(children: [
          Container(
            child: ListView(
              children: [
                const SizedBox(
                  height: 48,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Text("1Event Tournament").black().titleText(),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: const Text("Lapangan Tenis Brata Bakti").black().regularText(),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "PLAYER NAME",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ).gray(),
                      Row(
                        children: [
                          const Text(
                            "PTS",
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          ).gray(),
                          const SizedBox(
                            width: 35,
                          ),
                          const Text(
                            "W",
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          ).gray(),
                          const SizedBox(
                            width: 35,
                          ),
                          const Text(
                            "L",
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          ).gray(),
                          // const ItemNama()
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                const ItemNama(
                  isMe: true,
                  name: 'Stephen Strange (Me)',
                ),
                const SizedBox(
                  height: 10,
                ),
                const ItemNama(
                  isMe: false,
                  name: 'Tommy Bong',
                ),
                const SizedBox(
                  height: 10,
                ),
                const ItemNama(
                  isMe: false,
                  name: 'Wanda Maximoff',
                ),
                const SizedBox(
                  height: 10,
                ),
                const ItemNama(
                  isMe: false,
                  name: 'Tony Stark',
                ),
                const SizedBox(
                  height: 34,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "TOURNAMENT NAME",
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                ).gray(),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text("1Event Tournament").black().descriptionText(),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "DRAW SIZE",
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                ).gray(),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text("4").black().descriptionText(),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "3RD PLACE PLAYOFFS",
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                ).gray(),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text("On").black().descriptionText(),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "MATCH FORMAT",
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                ).gray(),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text("Single").black().descriptionText(),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Center(
                  child: const Text(
                    "VENUE DETAILS",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ).gray(),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                    child: Text(
                  "LAPANGAN TENNIS SENAYAN",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: OprimaryColor),
                )),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/ic/ic_location_primary.svg"),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text("Jakarta, Indonesia").descriptionText().black()
                        ],
                      ),
                      const Text("08.00 AM - 06.00 P  M").descriptionText().black()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BaseButton(
                ontap: () {
                  bottomSheetWidget(heightFactor: 0.9, context: context, child: const PaymentOption());
                },
                text: "CONTINUE",
                color: OTextsecondaryColor,
                outlineRadius: 0,
              )
            ],
          )
        ]),
      ),
    );
  }
}

class ItemNama extends StatefulWidget {
  final String name;
  final bool isMe;
  const ItemNama({
    Key? key,
    required this.name,
    required this.isMe,
  }) : super(key: key);

  @override
  State<ItemNama> createState() => _ItemNamaState();
}

class _ItemNamaState extends State<ItemNama> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[350],
                      radius: 20,
                      child: CircleAvatar(
                        backgroundColor: (widget.isMe) ? OprimaryColor : Colors.white,
                        radius: 19,
                        child: Icon(
                          Icons.person_outline_rounded,
                          color: (widget.isMe) ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.name).fieldTitleText(),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "0",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ).gray(),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      "0",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ).gray(),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      "0",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ).gray(),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(),
          )
        ],
      ),
    );
  }
}
