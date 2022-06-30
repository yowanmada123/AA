import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/widget/base/scaffold.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';

import 'package:flutter/material.dart';

import '../../model/region/region_res.dart';

class RegionListWithPullToReqPage extends StatefulWidget {
  const RegionListWithPullToReqPage({Key? key}) : super(key: key);

  @override
  State<RegionListWithPullToReqPage> createState() => _RegionListWithPullToReqPageState();
}

class _RegionListWithPullToReqPageState extends State<RegionListWithPullToReqPage> {
  List<Region> listRegion = [];
  var currentPage = 0;
  List<Region> regions = [];

  // ignore: prefer_final_fields
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  void onRefresh() async {
    setState(() {
      regions.clear();
    });
    currentPage = 0;
    await getData();
    _refreshController.refreshCompleted();
  }

  void onLoading() async {
    currentPage = currentPage + 10;
    await getData();
    // regions = regions + listRegion;
    _refreshController.loadComplete();
  }

  getData() async {
    String options = '''
      query listRegion{
        regions(filter: {}, paging: { limit: 10, offset: $currentPage}, sorting: []) {
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
    listRegion = newData;
    log(newData.toString());
    log(listRegion.length.toString());

    setState(() {
      regions.addAll(newData);
    });
    // loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "List Region",
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: SmartRefresher(
                controller: _refreshController,
                enablePullUp: true,
                onLoading: onLoading,
                onRefresh: onRefresh,
                child: ListView.builder(
                  itemCount: regions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final region = regions[index];
                    return ItemRegion(
                      item: region,
                      // state: gstate,
                      // onTap: () {
                      //   // Get.to(ListHealtPage());
                      // },
                    );
                  },
                ),
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
  const ItemRegion({
    Key? key,
    required this.item,
    // required this.state
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
