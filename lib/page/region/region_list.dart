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
  // final ValueChanged<String> onChanged;
  // const RegionListPage({
  //   Key? key,
  //   required this.onChanged,
  // }) : super(key: key);

  @override
  State<RegionListPage> createState() => _RegionListPageState();
}

class _RegionListPageState extends State<RegionListPage> {
  final loading = true.obs;
  final listRegion = <Region>[].obs;

  getData() async {
    String options = '''
      query listRegion{
        regions(filter: {}, paging: { limit: 10 }, sorting: []) {
          nodes {
             id
             name
             type
          }
          pageInfo {
            hasNextPage
            hasPreviousPage
          }
        }
      }
    ''';
    Map<String, dynamic>? data = await GraphQLBase().query(options);
    var list = data!['regions']['nodes'] as List;
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
                            // onChanged: (value) {},
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
  // final ValueChanged<String> onChanged;
  // final Region name;
  // final GlobalController state;
  const ItemRegion({
    Key? key,
    required this.item,
    // required this.onChanged,
    // required this.name,
    // required this.state
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // onChanged(item.name);
        // print(item.name);
        Navigator.pop(context, item.name);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                // spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1), // changes position of shadow
              )
            ],
          ),
          child: Row(
            children: [
              Expanded(
                // flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(color: Colors.black87),
                      ).titleText(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
