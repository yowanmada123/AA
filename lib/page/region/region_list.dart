import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/transaction/transaction_res.dart';
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

import '../../model/region/region_res.dart';


class RegionListPage extends StatefulWidget {
  const RegionListPage({Key? key}) : super(key: key);

  @override
  State<RegionListPage> createState() => _RegionListPageState();
}

class _RegionListPageState extends State<RegionListPage> {
  final loading = true.obs;
  final listRegion = <Region>[].obs;

  getData() async {
    String options = '''
      query listRegion{
        places(filter: {}, paging: { limit: 10 }, sorting: []) {
          nodes {
            address
            id
            images
            latitude
            longitude
            name
          }
          pageInfo {
            hasNextPage
            hasPreviousPage
          }
        }
      }
    ''';
    Map<String, dynamic>? data = await GraphQLBase().query(options);
    var list = data!['places']['nodes'] as List;
    List<Region> newData = list.map((i) => Region.fromMap(i)).toList();
    log(newData.length.toString());
    listRegion.value = newData;
    log(newData.toString());
    log(listRegion.length.toString());
    loading.value = false;
  }

  // final gstate = Get.find<GlobalController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "List Region",
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => Container(
                child: (loading.value)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: listRegion.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemRegion(
                            item: listRegion[index],
                            // state: gstate,
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
// ItemTransaction
class ItemRegion extends StatelessWidget {
  final Region item;
  // final GlobalController state;
  const ItemRegion({Key? key, required this.item, 
  // required this.state
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
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
                    item.address,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ).titleText(),
                  Text(item.latitude, style: TextStyle(color: OColorBrown))
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
                        child: Text(item.longitude).informationText(),
                      ),
                    ],
                  ),
                  // Text("Highlighted Text - Nunito Bold 14").pageTitleText(),
                ],
              ),
            )),
            // GestureDetector(
            //   onTap: () {
            //     Get.to(BookingInfo(
            //       item: item,
            //     ));
            //   },
            //   child: ClipRRect(
            //     borderRadius: const BorderRadius.only(
            //       topRight: Radius.circular(9),
            //       bottomRight: Radius.circular(9),
            //     ),
            //     child: Image.network(
            //       state.baseFile + item.images.replaceAll("\"", ""),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
