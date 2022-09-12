import 'dart:developer';

import 'package:boilerplate_flutter/model/user/profile.dart';
import 'package:boilerplate_flutter/page/kyc/kyc_edit_form.dart';
import 'package:boilerplate_flutter/widget/base/form/form_checkbox.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/base/form/form_search_widget.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../graphql_base.dart';

class ListUserPage extends StatefulWidget {
  ListUserPage({Key? key}) : super(key: key);

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
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
      title: "Member List",
      body: Column(children: [
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
                    child: SizedBox(
                      width: Get.width,
                      // height: Get.height,
                      child: ListView.builder(
                          itemCount: listProfile.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemNama(
                              item: listProfile[index],
                              // onTap: () {
                              //   // Get.to(ListHealtPage());
                              // },
                            );
                          }),
                    ),
                  ),
          ),
        ),
        // const SizedBox(height: ,),
      ]),
    );
  }
}

class ItemNama extends StatefulWidget {
  final Profile item;
  const ItemNama({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<ItemNama> createState() => _ItemNamaState();
}

class _ItemNamaState extends State<ItemNama> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          KYCEditFormPage(
            profile: widget.item,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(item.id),
                            Text(widget.item.email).titleText(),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              "082335645799",
                              style: TextStyle(fontSize: 10),
                            )
                            // Text(widget.item.id).informationText(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // GestureDetector(
                //     onTap: () => Get.to(
                //           KYCEditFormPage(
                //             profile: widget.item,
                //           ),
                //         ),
                //     child: const Icon(Icons.arrow_right))
              ],
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
