import 'dart:developer';

import 'package:boilerplate_flutter/all_screen.dart';
import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/model/tournament/create_data_tournamert.dart';
import 'package:boilerplate_flutter/page/booking/booking_list.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/place/place_edit.dart';
import 'package:boilerplate_flutter/page/place/place_form.dart';
import 'package:boilerplate_flutter/page/place/place_list.dart';
import 'package:boilerplate_flutter/page/tournament/list_other_user_page.dart';
import 'package:boilerplate_flutter/page/tournament/tournament_controller.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/alertx.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';
import 'package:boilerplate_flutter/widget/base/form/form.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TournamentCreatePage extends StatefulWidget {
  const TournamentCreatePage({Key? key}) : super(key: key);

  @override
  State<TournamentCreatePage> createState() => _TournamentCreatePageState();
}

class _TournamentCreatePageState extends State<TournamentCreatePage> {
  // List<Place> listPlace = [];
  // late String placeValue = "Jakarta";
  final loading = false;
  final gstate = Get.find<GlobalController>();
  final ctournament = Get.put(TournamentController());
  TextEditingController nameController = TextEditingController();
  TextEditingController drawSizeController = TextEditingController();
  TextEditingController tournamentFormatController = TextEditingController();
  TextEditingController matchFormatController = TextEditingController();
  int tournamentFormat = -1;
  int matchFormat = -1;
  int playsOffFormat = -1;
  int venueBookingFormat = -1;
  List tournamentOption = ['Knockout', 'Group'];
  List matchOption = ['Single', 'Double'];
  List playsOffOption = ['On', 'Off'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "Create Tournament Detail",
      backgroundColor: const Color(redBooked),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text("Fill in your Tournament Details").titleText().black(),
              const SizedBox(
                height: 4,
              ),
              const Text("Lorem ipsum dolor sit amet").regularText().black(),
              const SizedBox(
                height: 15,
              ),
              OFormText(
                title: "TOURNAMENT NAME",
                titleColor: OTextPrimaryColor,
                controller: nameController,
                hintText: "Tournament Name",
                // icon: const IconData(0xf018, fontFamily: 'MaterialIcons'),
              ),
              OFormText(
                title: "DRAW SIZE",
                titleColor: OTextPrimaryColor,
                controller: drawSizeController,
                hintText: "Number of Participants",
                // icon: const IconData(0xf018, fontFamily: 'MaterialIcons'),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TOURNAMENT FORMAT",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: OTextPrimaryColor),
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
                        itemCount: tournamentOption.length,
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
                                tournamentFormat = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: tournamentFormat == index ? OprimaryColor : Colors.white,
                                  border: Border.all(
                                    color: tournamentFormat == index ? OprimaryColor : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              // check if the index is equal to the selected Card integer

                              child: Expanded(
                                child: Center(
                                  child: Text(
                                    tournamentOption[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: tournamentFormat == index ? Colors.white : Colors.black,
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
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MATCH FORMAT",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: OTextPrimaryColor),
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
                        itemCount: matchOption.length,
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
                                matchFormat = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: matchFormat == index ? OprimaryColor : Colors.white,
                                  border: Border.all(
                                    color: matchFormat == index ? OprimaryColor : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              // check if the index is equal to the selected Card integer

                              child: Expanded(
                                child: Center(
                                  child: Text(
                                    matchOption[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: matchFormat == index ? Colors.white : Colors.black,
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
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "3RD PLACE PLAYOFFS",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: OTextPrimaryColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: Get.width,
                    height: 46,
                    child: GridView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.vertical,
                        itemCount: playsOffOption.length,
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
                                playsOffFormat = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: playsOffFormat == index ? OprimaryColor : Colors.white,
                                  border: Border.all(
                                    color: playsOffFormat == index ? OprimaryColor : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              // check if the index is equal to the selected Card integer
                              child: Expanded(
                                child: Center(
                                  child: Text(
                                    playsOffOption[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: playsOffFormat == index ? Colors.white : Colors.black,
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
              const SizedBox(
                height: 40,
              ),
              Text(
                "TOURNAMENT PARTICIPANTS",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: OTextPrimaryColor),
              ),
              const SizedBox(
                height: 16,
              ),
              ItemNama(
                name: "Stephen Strange (Me)",
                color: OprimaryColor,
                numb: '1.',
              ),
              const ItemNama(
                name: "Tommy Bong",
                numb: '2.',
              ),
              const ItemNama(
                name: "Wanda Maximoff",
                numb: '3.',
              ),
              const ItemNama(
                name: "Tony Stark",
                numb: '4.',
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                height: 46,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(ListOtherUserPage());
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/ic/ic_add_member.svg"),
                        const SizedBox(
                          width: 16,
                        ),
                        const Text("Add New Participants").pageTitleText().black()
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 15,
                  )
                ]),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "VENUE BOOKING",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: OTextPrimaryColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: Get.width,
                    height: 46,
                    child: GridView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.vertical,
                        itemCount: playsOffOption.length,
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
                                venueBookingFormat = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: venueBookingFormat == index ? OprimaryColor : Colors.white,
                                  border: Border.all(
                                    color: venueBookingFormat == index ? OprimaryColor : Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              // check if the index is equal to the selected Card integer

                              child: Expanded(
                                child: Center(
                                  child: Text(
                                    playsOffOption[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: venueBookingFormat == index ? Colors.white : Colors.black,
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
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BaseButton(
              height: 56,
              ontap: () {
                // print(nameController.text);
                // print(drawSizeController.text);
                // log(nameController.toString());
                // log(nameController.text);
                saveData();
                Get.to(BookingListPage());
              },
              text: "CONTINUE",
              outlineRadius: 0,
              color: OTextPrimaryColor,
            ),
          ],
        )
      ]),
    );
  }

  String getVenueType(int venueBookingFormat) {
    String format = '';
    try {
      if (tournamentFormat == 0) {
        format = "On";
      } else if (tournamentFormat == 1) {
        format = "Off";
      }
    } catch (e, s) {
      Alertx().error("Please Fill Venue Type");
    }
    return format;
  }

  String getTournamentFormat(int tournamentFormat) {
    String format = '';
    try {
      if (tournamentFormat == 0) {
        format = "Knockout";
      } else if (tournamentFormat == 1) {
        format = "Group";
      }
    } catch (e, s) {
      Alertx().error("Please Fill Tournament Format");
    }
    return format;
  }

  String getMatchFormat(int matchFormat) {
    String format = '';
    try {
      if (matchFormat == 0) {
        format = "Single";
      } else if (matchFormat == 1) {
        format = "Double";
      }
    } catch (e, s) {
      Alertx().error("Please Fill Match Format");
    }
    return format;
  }

  saveData() {
    int drawSize = 1;
    if (nameController.text == null) {
      Alertx().error("Please Fill The Tournament Name");
    } else if (drawSizeController.text == null) {
      Alertx().error("Please Fill The Draw Size");
    } else {
      try {
        drawSize = int.parse(drawSizeController.text);
        log(drawSize.toString());
      } catch (e) {
        Alertx().error("Please Fill The Draw Size with a Number");
      }

      String formatTournament = getTournamentFormat(tournamentFormat);
      String formatMatch = getMatchFormat(matchFormat);
      String venueType = getVenueType(venueBookingFormat);

      log(nameController.text);
      log(drawSize.toString());
      log(formatTournament);
      log(formatMatch);
      log(venueType);

      ctournament.tournamentdata.name = nameController.text;
      ctournament.tournamentdata.drawSize = drawSize;
      ctournament.tournamentdata.tournamentFormat = formatTournament;
      ctournament.tournamentdata.matchFormat = formatMatch;

      log(ctournament.tournamentdata.name.toString());
      log(ctournament.tournamentdata.drawSize.toString());
      log(ctournament.tournamentdata.tournamentFormat.toString());
      log(ctournament.tournamentdata.matchFormat.toString());

    }
  }
}

class ItemNama extends StatefulWidget {
  final String name;
  final Color? color;
  final String numb;
  const ItemNama({
    Key? key,
    required this.name,
    this.color,
    required this.numb,
  }) : super(key: key);

  @override
  State<ItemNama> createState() => _ItemNamaState();
}

class _ItemNamaState extends State<ItemNama> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.numb,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: (widget.color == null) ? Colors.grey[350] : widget.color,
                        radius: 20,
                        child: CircleAvatar(
                          backgroundColor: (widget.color == null) ? Colors.white : widget.color,
                          radius: 19,
                          child: Icon(
                            Icons.person_outline_rounded,
                            color: (widget.color == null) ? Colors.grey[350] : Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.name,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // Container(
                  //   // width: double.infinity,
                  //   // padding: const EdgeInsets.all(8.0),
                  //   decoration: BoxDecoration(
                  //     border: Border(
                  //       top: BorderSide(width: 2, color: Colors.lightBlue.shade50),
                  //     ),
                  //   ),
                  //   child: Text("data"),
                  // )
                ],
              ),
            ],
          ),
          const Divider(),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
