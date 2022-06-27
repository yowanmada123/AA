
import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/widget/base/scaffold.dart';
import 'package:boilerplate_flutter/widget/base/search_widget.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/region/region_res.dart';

class RegionListPage extends StatefulWidget {
  @override
  State<RegionListPage> createState() => _RegionListPageState();
}

class _RegionListPageState extends State<RegionListPage> {
  final loading = true.obs;
  var listRegion = <Region>[].obs;
  late List<Region> regions;
  String query = '';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    regions = listRegion;
  }

  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "List Region",
      body: Column(
        children: [
          buildSearch(),
          Expanded(
            child: Obx(
              () => Container(
                child: (loading.value)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: regions.length,
                        itemBuilder: (BuildContext context, int index) {
                          final region = regions[index];
                          return ItemRegion(
                            item: region,
                          );
                        }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Region Name',
        onChanged: searchRegion,
      );

  void searchRegion(String query) {
    final regions = listRegion.where((region) {
      final titleLower = region.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.regions = regions;
    });
  }
}

class ItemRegion extends StatelessWidget {
  final Region item;

  const ItemRegion({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
