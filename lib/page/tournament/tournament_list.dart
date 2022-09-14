import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/model/tournament/tournament_rest.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/place/place_edit.dart';
import 'package:boilerplate_flutter/page/place/place_form.dart';
import 'package:boilerplate_flutter/page/tournament/tournament_create.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TournamentListPage extends StatefulWidget {
  const TournamentListPage({Key? key}) : super(key: key);

  @override
  State<TournamentListPage> createState() => _TournamentListPageState();
}

class _TournamentListPageState extends State<TournamentListPage> {
  final listTurnament = <Turnaments>[].obs;
  final loading = true.obs;

  getData() async {
    String options = '''
      
query listTurnament{
  Turnaments(filter: {}, paging: { limit: 10 }, sorting: []) {
    nodes {
#       booking_time
#       createdAt
#       draw_size
#       format
      id
#       match
      name
#       updatedAt
#       veneu
    }
    pageInfo {
      hasNextPage
      hasPreviousPage
    }
  }
}

    ''';
    Map<String, dynamic>? data = await GraphQLBase().query(options);
    var list = data!['Turnaments']['nodes'] as List;
    List<Turnaments> newData = list.map((i) => Turnaments.fromMap(i)).toList();
    log(newData.length.toString());
    listTurnament.value = newData;
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
      title: "List Tournament",
      backgroundColor: const Color(redBooked),
      body: Stack(children: [
        Obx(
          () => Container(
            child: (loading.value)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: listTurnament.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(listTurnament[index].name),
                      );
                      // Item(
                      //   item: listTurnament[index],
                      //   // state: gstate,
                      //   // onTap: () {
                      //   //   // Get.to(ListHealtPage());
                      //   // },
                      // );
                    }),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BaseButton(
              height: 56,
              ontap: () {
                Get.to(const TournamentCreatePage());
              },
              text: "CREATE",
              outlineRadius: 0,
              color: OTextPrimaryColor,
            ),
          ],
        )
      ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Get.to(const PlaceFormPage()),
      //   child: const Icon(Icons.add),
      //   // child: Obx(() => Icon(GlobalController.to.isDark ? Icons.dark_mode : Icons.light_mode)),
      // ),
    );
  }
}

class Item extends StatelessWidget {
  final Turnaments item;
  // final GlobalController state;

  const Item({
    Key? key,
    required this.item,
    // required this.state
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cGlobal = Get.find<GlobalController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // cGlobal.selectPlace.clear();
          // // cGlobal.selectPlace.add(item);
          // cGlobal.selectPlace.clear();
          // cGlobal.selectProduct.clear();
          // cGlobal.selectPaymentMethods.clear();
          // cGlobal.selectScheduleTime.clear();
          // Get.to(UpdatePlacePage(
          //   item: item,
          // ));
        },
        child: Container(
            height: 200,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(9),
                )),
            child: Column(
              children: [
                Stack(children: [
                  // Container(
                  //   height: 100,
                  //   width: double.infinity,
                  //   child: ClipRRect(
                  //     borderRadius: const BorderRadius.all(
                  //       Radius.circular(9),
                  //     ),
                  //     child:
                  //     Image.network(
                  //       item.images,
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(9),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          item.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        ).titleText(),
                      ],
                    ),
                  ),
                ]),
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 2),
                              //   child: Expanded(
                              //     child: Text(item.description).titleText(),
                              //   ),
                              // ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10, bottom: 15),
                              //   child: Expanded(
                              //     child: Text(item.region.name).informationText(),
                              //   ),
                              // ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8, right: 5),
                                child: SvgPicture.asset("assets/ic/ic_location.svg"),
                              ),
                              // Expanded(
                              //   child: Text(item.address).informationText(),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (c) => AlertDialog(
                                  title: Container(),
                                  content: Container(
                                    color: Colors.white,
                                    // height: 80,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Are You Sure Want To Delete The Data ?"),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                Navigator.pop(context);
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "No",
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                deleteItem();
                                                Navigator.pop(context);
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("Yes"),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Icon(Icons.delete),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }

  deleteItem() async {
    String itemID = item.id.toString();
    String options = '''
      mutation deleteOnePlace{
        deleteOnePlace(input: {
          id: "$itemID"
        }) {
          address
          description
          distance
          id
          image_path
          images
          latitude
          longitude
          name
        }
      }
    ''';
    log("OYOY");
    Map<String, dynamic>? data = await GraphQLBase().mutate(options);
    var message = data!['deleteOnePlace'];
    log(message.toString());
  }
}
