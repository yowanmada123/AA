import 'dart:developer';

import 'package:boilerplate_flutter/all_screen.dart';
import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/place/place_edit.dart';
import 'package:boilerplate_flutter/page/place/place_form.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
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
  List<Place> listPlace = [];
  late String placeValue = "Jakarta";
  final loading = false;
  final gstate = Get.find<GlobalController>();
  final _nameController = TextEditingController(text: '');
  int tournamentFormat = -1;
  int matchFormat = -1;
  int playsOffFormat = -1;
  int venueBookingFormat = -1;
  List matchOption = ['Knockout', 'Group'];
  List tournamentOption = ['Single', 'Double'];
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
      backgroundColor: Color(redBooked),
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
                controller: _nameController,
                formType: FormType.email,
                hintText: "Tournament Name",
                // icon: const IconData(0xf018, fontFamily: 'MaterialIcons'),
              ),
              OFormText(
                title: "DRAW SIZE",
                titleColor: OTextPrimaryColor,
                controller: _nameController,
                formType: FormType.email,
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
                color: OprimaryColor, numb: '1.',
              ),
              const ItemNama(
                name: "Tommy Bong",numb: '2.',
              ),
              const ItemNama(
                name: "Wanda Maximoff",numb: '3.',
              ),
              const ItemNama(
                name: "Tony Stark",
                numb: '4.',
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
                Get.to(const AllScreen());
              },
              text: "CREATE",
              outlineRadius: 0,
              color: OTextPrimaryColor,
            ),
          ],
        )
      ]),
    );
  }
}

class ItemNama extends StatefulWidget {
  final String name;
  final Color? color;
  final String numb;
  const ItemNama({
    Key? key,
    required this.name,
    this.color, required this.numb,
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
