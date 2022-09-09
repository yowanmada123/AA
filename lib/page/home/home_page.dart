import 'package:boilerplate_flutter/page/tournament/tournament_list.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../event_option.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        Column(
          children: [
            Container(
              height: 180,
              width: Get.width,
              decoration: BoxDecoration(color: OprimaryColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/ic/OM1icon.png"),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("One", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                            Text("Event", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 28,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white.withOpacity(0.2)),
                      child: Center(
                        child: const Text("Senin, 31 Januari 2022").white(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Senin, 31 Januari 2022",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ).black(),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ItemWidget(
              description: "Book venue blablabla",
              icon: "assets/ic/ic_calender.svg",
              name: "Booking",
              onTap: () {
                Get.to(const EventOptionPage());
              },
            ),
            ItemWidget(
              description: "Find varies of coach blablabla",
              icon: "assets/ic/ic_burble.svg",
              name: "Training",
              onTap: () {},
            ),
            ItemWidget(
              description: "Find varies of coach blablabla",
              icon: "assets/ic/ic_trophy.svg",
              name: "Tournament",
              onTap: () {
                Get.to(const TournamentListPage());
              },
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 86,
              ),
              Stack(children: [
                SvgPicture.asset("assets/ic/ic_card.svg"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person_outline_rounded,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Stephen Strange").pageTitleText().white(),
                              const SizedBox(
                                height: 2,
                              ),
                              const Text("StephenStrange@gmail.com").descriptionText().white(),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 85,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircleAvatar(backgroundColor: Colors.white, radius: 2),
                          SizedBox(
                            width: 8,
                          ),
                          CircleAvatar(backgroundColor: Colors.white, radius: 2),
                          SizedBox(
                            width: 8,
                          ),
                          CircleAvatar(backgroundColor: Colors.white, radius: 2),
                          SizedBox(
                            width: 8,
                          ),
                          CircleAvatar(backgroundColor: Colors.white, radius: 2),
                          // const SizedBox(width: 2,),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ],
          ),
        )
      ])),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String icon;
  final String name;
  final String description;
  final Function() onTap;
  const ItemWidget({Key? key, required this.icon, required this.name, required this.description, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 15),
              height: 67,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(icon),
                  const SizedBox(
                    width: 23,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ).black(),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        description,
                        style: TextStyle(fontSize: 12),
                      ).black(),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
