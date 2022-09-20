import 'dart:developer';

import 'package:boilerplate_flutter/model/user/profile.dart';
import 'package:boilerplate_flutter/page/booking/booking_controller.dart';
import 'package:boilerplate_flutter/page/kyc/kyc_edit_form.dart';
import 'package:boilerplate_flutter/page/maps/maps_open_street.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';
import 'package:boilerplate_flutter/widget/base/button/button_small_outline.dart';
import 'package:boilerplate_flutter/widget/base/form/form.dart';
import 'package:boilerplate_flutter/widget/base/form/form_checkbox.dart';
import 'package:boilerplate_flutter/widget/base/form/form_radio_filter.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/base/form/form_search_widget.dart';
import 'package:boilerplate_flutter/widget/base/form/form_text.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../graphql_base.dart';

class DetailTrainerPage extends StatefulWidget {
  DetailTrainerPage({Key? key}) : super(key: key);

  @override
  State<DetailTrainerPage> createState() => _DetailTrainerPageState();
}

class _DetailTrainerPageState extends State<DetailTrainerPage> {
  final loading = true.obs;
  final listProfile = <Profile>[].obs;
  String query = '';
  final cBooking = Get.put(BookingController());
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
      title: "Training Detail",
      body: Stack(
        children:[
          Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("VENUE DETAILS").descriptionText().red(),
                const SizedBox(
                  height: 13,
                ),
                const Text("LAPANGAN TENNIS").fieldTitleText().black(),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset("assets/ic/ic_location-primary.svg"),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text("Jakarta, Indonesia").regularBigText().black(),
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                
              ],
            ),
          ),
          const Divider(
            thickness: 8,
            color: Color(0xffF6F6F6),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("TRAINER DETAILS").descriptionText().red(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/trainer1.png"),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    const Text("Peter Parker").descriptionText().black(),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 8,
            color: Color(0xffF6F6F6),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("SCHEDULE DETAILS").descriptionText().red(),
                const SizedBox(
                  height: 11,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/ic/ic_calender_19.svg"),
                        const SizedBox(
                          width: 13,
                        ),
                        const Text("3 Februari 2022 ").regularText().black(),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("11:00 AM").regularText().black(),
                        const SizedBox(
                          width: 13,
                        ),
                        const Text("-").regularText().black(),
                        const SizedBox(
                          width: 13,
                        ),
                        const Text("01:00 PM").regularText().black(),
                      ],
                    )
      
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 8,
            color: Color(0xffF6F6F6),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("BOOKING FOR").descriptionText().red(),
                const SizedBox(
                  height: 11,
                ),
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.grey[350],
                        radius: 20,
                        child: CircleAvatar(
                          backgroundColor: OprimaryColor,
                          radius: 19,
                          child: const Icon(
                            Icons.person_outline_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("Stephen Strange (Me)").descriptionText().black(),
                  ],
                ),
                const SizedBox(
                  height: 21,
                ),
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.grey[350],
                        radius: 20,
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 19,
                          child: Icon(
                            Icons.person_outline_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("Tony Stark").descriptionText().black(),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          Center(child: BaseButton(outlineRadius: 16, width: 317 ,height: 32,ontap: (){},text: "Add Member", iconSvg: "assets/ic/ic_add_circle.svg", color: OprimaryColor,)),
          const SizedBox(
            height: 44,
          ),
          // Obx(
          //   () => Container(
          //     child: (loading.value)
          //         ? const Center(
          //             child: CircularProgressIndicator(),
          //           )
          //         : Expanded(
          //             child: SizedBox(
          //               width: Get.width,
          //               // height: Get.height,
          //               child: ListView.builder(
          //                   itemCount: listProfile.length,
          //                   itemBuilder: (BuildContext context, int index) {
          //                     return ItemTrainer(
          //                       item: listProfile[index],
          //                       // onTap: () {
          //                       //   // Get.to(ListHealtPage());
          //                       // },
          //                     );
          //                   }),
          //             ),
          //           ),
          //   ),
          // ),
        ]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BaseButton(ontap: (){}, text: "CONTINUE", color: OTextsecondaryColor, textColor: Colors.white, outlineRadius: 0,)
          ],
        ),
        
        ] 
      ),
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
  final Profile item;
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
                              const Text("Tony Stark").descriptionText().black()
                            ],
                          ),
                          const Text("Dokter Umum").regularText().gray(),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("RS Medistra").regularText().gray(),
                                Container(
                                    width: 80,
                                    height: 32,
                                    child: BaseButton(
                                      ontap: () {},
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
                          const Text("Rp123.000").pageTitleText().black(),
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
