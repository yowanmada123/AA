import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../graphql_base.dart';
import '../../model/user/user.dart';

class KycList extends StatefulWidget {
  KycList({Key? key}) : super(key: key);

  @override
  State<KycList> createState() => _KycListState();
}

class _KycListState extends State<KycList> {
  final loading = true.obs;
  final listProfile = <UserRes>[].obs;

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
      address
      createdAt
      dateOfBirth
      email
      fullname
      gender
      id
      phone
      updatedAt
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
    List<UserRes> newData = list.map((i) => UserRes.fromJson(i)).toList();
    log(newData.length.toString());
    listProfile.value = newData;
    log(newData.toString());
    log(listProfile.length.toString());
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Obx(
        () => Container(
          child: (loading.value)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
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
    );
  }
}

class ItemNama extends StatelessWidget {
  final UserRes item;
  const ItemNama({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Text(item.id),
              Text(item.email),
            ],
          ),
        ),
      ),
    );
  }
}
