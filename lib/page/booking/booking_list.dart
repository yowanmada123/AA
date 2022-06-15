import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/main.dart';
import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/page/booking/booking_info.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/appbar.dart';
import 'package:boilerplate_flutter/widget/base_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/list_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookingListPage extends StatefulWidget {
  const BookingListPage({Key? key}) : super(key: key);

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  final loading = true.obs;
  final listPlace = <Place>[].obs;
  getData() async {
    String options = '''
      query {
        places(filter: {}, paging: { limit: 100 }, sorting: []) {
          pageInfo {
            hasNextPage
            hasPreviousPage
          }
          nodes {
            address
            city
            id
            images
            latitude
            longitude
            name
          }
        }
      }
    ''';
    Map<String, dynamic>? data = await GraphQLBase().query(options);
    var list = data!['places']['nodes'] as List;
    List<Place> newData = list.map((i) => Place.fromMap(i)).toList();
    log(newData.length.toString());
    listPlace.value = newData;
    log(newData.toString());
    log(listPlace.length.toString());
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
      title: "List Place",
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OFilterList(
                    title: "Filter",
                    // "Top Navigation Button",
                    icon: "assets/ic/ic_filter.svg",
                    // onPressed: ,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: OFilterList(
                      title: "Sort By",
                      // "Nunito Bold 12 ",
                      icon: "assets/ic/ic_sort.svg",
                      // onPressed: ,
                    )),
                Expanded(
                    flex: 1,
                    child: OFilterList(
                      title: "Maps",
                      // "Top Navigation Button",
                      icon: "assets/ic/ic_nav.svg",
                      // onPressed: ,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => Container(
                child: (loading.value)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemPlace extends StatelessWidget {
  final Place item;
  final GlobalController state;
  const ItemPlace({Key? key, required this.item, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(9),
            )),
        child: Row(
          children: [
            Expanded(
                // flex: 1,
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ).titleText(),
                  Text(item.city, style: TextStyle(color: OColorBrown))
                      .informationText(),
                  Expanded(child: Container()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: SvgPicture.asset("assets/ic/ic_location.svg"),
                      ),
                      Expanded(
                        child: Text(item.address).informationText(),
                      ),
                    ],
                  ),
                  // Text("Highlighted Text - Nunito Bold 14").pageTitleText(),
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                Get.to(BookingInfo(
                  item: item,
                ));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(9),
                  bottomRight: Radius.circular(9),
                ),
                child: Image.network(
                  state.baseFile + item.images.replaceAll("\"", ""),
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
