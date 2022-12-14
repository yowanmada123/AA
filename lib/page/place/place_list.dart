import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/page/book_controller.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/maps/maps_open_street.dart';
import 'package:boilerplate_flutter/page/place/place_edit.dart';
import 'package:boilerplate_flutter/page/place/place_form.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PlaceListPage extends StatefulWidget {
  const PlaceListPage({Key? key}) : super(key: key);

  @override
  State<PlaceListPage> createState() => _PlaceListPageState();
}

class _PlaceListPageState extends State<PlaceListPage> {
  List<Place> listPlace = [];
  late String placeValue = "Jakarta";

  getData() async {
    String options = '''
      query listPlaces{
        places(filter: {}, paging: { limit: 10 }, sorting: []) {
          nodes {
            address
            description
            distance
            id
            images
            image_path
            latitude
            longitude
            name
            region {
              name
              id
              type
            }
          }
          pageInfo {
            hasNextPage
            hasPreviousPage
          }
        }
      }
    ''';

    log("OYOY");
    try {
      Map<String, dynamic>? data = await GraphQLBase().query(options);
      var list = data!['places']['nodes'] as List;
      List<Place> newData = list.map((i) => Place.fromMap(i)).toList();
      setState(() {
        listPlace = newData;
      });
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
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
      body: ListView.builder(
          itemCount: listPlace.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemPlace(
              item: listPlace[index],
              state: gstate,
              // onTap: () {
              //   // Get.to(ListHealtPage());
              // },
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Get.to(const PlaceFormPage()),
      //   child: const Icon(Icons.add),
      //   // child: Obx(() => Icon(GlobalController.to.isDark ? Icons.dark_mode : Icons.light_mode)),
      // ),
    );
  }
}

class ItemPlace extends StatelessWidget {
  final Place item;
  final GlobalController state;

  const ItemPlace({Key? key, required this.item, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cGlobal = Get.find<GlobalController>();
    final cBook = Get.find<BookController>();
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
          cBook.selectPlace.clear();
          cBook.selectPlace.add(item);
          Get.to(ChoseLocation(
            item: item,
          ));
        },
        child: Container(
            // height: 200,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(9),
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(9),
                      ),
                      child: Image.network(
                        mainbaseFile + "/" + item.images,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 2),
                            child: Text(item.description).titleText(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 15),
                          child: Expanded(
                            child: Text(item.region.name).informationText(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 5),
                          child: SvgPicture.asset("assets/ic/ic_location.svg"),
                        ),
                        Expanded(
                          child: Text(item.address).informationText(),
                        ),
                      ],
                    ),
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
