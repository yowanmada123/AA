import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:boilerplate_flutter/model/user/profile.dart';
import 'package:boilerplate_flutter/page/tournament/tournament_controller.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';
import 'package:boilerplate_flutter/widget/base/form/form_checkbox.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/base/form/form_search_widget.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';

import '../../graphql_base.dart';
import '../book_controller.dart';

class ListOtherUserPage extends StatefulWidget {
  const ListOtherUserPage({Key? key}) : super(key: key);

  @override
  State<ListOtherUserPage> createState() => _ListOtherUserPageState();
}

class _ListOtherUserPageState extends State<ListOtherUserPage> {
  final loading = true.obs;
  final listProfile = <ProfileChosser>[].obs;
  final booking = Get.find<BookController>();

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
    List<ProfileChosser> newData = list.map((i) => ProfileChosser(isSelected: false, profile: Profile.fromMap(i))).toList();

    log(newData.length.toString());
    listProfile.value = newData;
    log(newData.toString());
    log(listProfile.length.toString());
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "Member List",
      body: Stack(children: [
        Column(children: [
          Container(
            width: Get.width,
            // height: 70,
            child: OSearchWidget(
              text: query,
              hintText: 'Member Name',
              onChanged: (String) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xffD8D8D8))),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/ic/ic_add_member.svg"),
                    const SizedBox(
                      width: 18,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Add New Member").pageTitleText().black(),
                        const SizedBox(
                          width: 2,
                        ),
                        SizedBox(width: 207, child: const Text("Fill in new member details to add new member").regularText().black()),
                      ],
                    )
                  ],
                ),
                const Icon(Icons.keyboard_arrow_right_outlined)
              ]),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(
            () => Container(
              child: (loading.value)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: listProfile.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                listProfile[index].isSelected = !listProfile[index].isSelected;
                                listProfile.refresh();
                              },
                              child: ItemNama(
                                item: listProfile[index],
                              ),
                            );
                          }),
                    ),
            ),
          ),
          // const SizedBox(height: ,),
        ]),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Member Selected:").regularText().black(),
                  Text("0 Name").pageTitleText().black(),
                ],
              ),
            ),
            BaseButton(
              ontap: () {
                booking.profile.clear();
                for (var element in listProfile) {
                  if (element.isSelected) booking.profile.add(element.profile);
                }
                Get.back();
              },
              text: "CONTINUE",
              color: Colors.grey,
              outlineRadius: 0,
            )
          ],
        )
      ]),
    );
  }
}

class ItemNama extends StatelessWidget {
  final ProfileChosser item;
  const ItemNama({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              (item.isSelected) ? const Icon(Icons.check_box_outlined) : const Icon(Icons.check_box_outline_blank),
              const SizedBox(width: 10),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(item.id),
                    Text(item.profile.fullname).titleText(),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(item.profile.email),
                    // Text(widget.item.id).informationText(),
                  ],
                ),
              ),
            ],
          ),
          // Checkbox(value: widget.item.isSelected, onChanged: (val) {}),
          // OSquareCheckBox(
          //   text: "",
          //   accept: widget.item.isSelected,
          //   color: OTextsecondaryColor,
          //   fungsi: (val) {},
          //   child:
          // ),
          const Divider()
        ],
      ),
    );
  }
}

class ProfileChosser {
  bool isSelected;
  Profile profile;
  ProfileChosser({
    required this.isSelected,
    required this.profile,
  });
}
