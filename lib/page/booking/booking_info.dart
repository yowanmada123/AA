import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/product/product.dart';
import 'package:boilerplate_flutter/model/product/schedule.dart';
import 'package:boilerplate_flutter/page/booking/booking_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../model/place/place_res.dart';
import '../../widget/button_bar.dart';
import '../../widget/extention/base_ext.dart';

class BookingInfo extends StatefulWidget {
  final Place item;
  const BookingInfo({Key? key, required this.item}) : super(key: key);

  @override
  State<BookingInfo> createState() => _BookingInfoState();
}

class _BookingInfoState extends State<BookingInfo> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final loading = true.obs;
  final selectProduct = 0.obs;
  final listProduct = <Product>[].obs;
  final listSchedule = <Schedule>[].obs;
  getData() async {
    String options = '''
     
        query {
          products(filter: {}, paging: { limit: 20 }, sorting: []) {
            pageInfo {
              hasNextPage
              hasPreviousPage
            }
            nodes {
              createdAt
              description
              id
              place {
                address
                region {
                  id
                  name
                  type
                }
                id
                images
                latitude
                longitude
                name
              }
              name
              price
              schedules {
                dayname
                endTime
                id
                startTime
                timePerSession
              }
              updatedAt
            }
          }
        }

    ''';
    Map<String, dynamic>? data = await GraphQLBase().query(options);
    var list = data!['products']['nodes'] as List;
    List<Product> newData = list.map((i) => Product.fromMap(i)).toList();
    log(newData.length.toString());
    listProduct.value = newData;
    if (newData.isNotEmpty) {
      listSchedule.value = listProduct.first.schedules;
    }

    log(newData.toString());
    log(listProduct.length.toString());
    loading.value = false;
  }

  @override
  void initState() {
    super.initState();
    getData();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: MySliverAppBar(image: widget.item.getImageUrl(), expandedHeight: 300),
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (_, index) => Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [Text(widget.item.name).titleText(), Text('0,1 Km')],
                                    ),
                                    Text(widget.item.region.name),
                                    const SizedBox(height: 20),
                                    Text(widget.item.address),
                                  ],
                                ),
                              ),
                              DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    TabBar(
                                      labelColor: Colors.black,
                                      labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                                      unselectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                      isScrollable: true,
                                      indicatorColor: Theme.of(context).colorScheme.primary,
                                      onTap: (index) {
                                        // Tab index when user select it, it start from zero
                                      },
                                      tabs: const [
                                        Tab(
                                          text: "About",
                                        ),
                                        Tab(
                                          text: "Opening Hours",
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 550,
                                      child: TabBarView(
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Page Subtitle - Nunito Bold 12").fieldTitleText(),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              ItemInfo(),
                                              ItemInfo(),
                                              ItemInfo(),
                                              ItemInfo(),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Obx(
                                                () => Container(
                                                  child: (loading.value)
                                                      ? Center(
                                                          child: CircularProgressIndicator(),
                                                        )
                                                      : Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: SizedBox(
                                                            height: 35,
                                                            child: ListView.builder(
                                                                // shrinkWrap:
                                                                //     true,
                                                                scrollDirection: Axis.horizontal,
                                                                itemCount: listProduct.length,
                                                                itemBuilder: (BuildContext context, int index) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets.only(left: 8, right: 12),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        listSchedule.value = listProduct[index].schedules;
                                                                        selectProduct.value = index;
                                                                      },
                                                                      child: Obx(
                                                                        () => Container(
                                                                          decoration: BoxDecoration(
                                                                            color: (selectProduct.value == index) ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primaryContainer,
                                                                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                                                                            child: Center(
                                                                              child: Text(listProduct[index].name).fieldTitleText().white(),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              SizedBox(
                                                  // height: 200,
                                                  child: Obx(
                                                () => ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemCount: listSchedule.length,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return OpeningHour(
                                                        schedule: listSchedule[index],
                                                      );
                                                    }),
                                              )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    childCount: 1),
              ),
            ],
          ),
          Positioned(
              top: 0,
              child: SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset("assets/ic/ic_back.svg"),
                        ),
                      ),
                      // Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset("assets/ic/ic_bookmark.svg"),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
      bottomNavigationBar: OButtonBar(
          title: "BOOK NOW",
          onPressed: () {
            Get.to(BookingDate(
              product: listProduct[selectProduct.value],
            ));
          }),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final String image;
  final double expandedHeight;

  MySliverAppBar({
    required this.expandedHeight,
    required this.image,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      // overflow: Overflow.visible,
      children: [
        Image.network(
          image,
          width: double.infinity,
          height: 100,
          fit: BoxFit.cover,
        ),
        Positioned(
            // top: expandedHeight / 2 - shrinkOffset,
            bottom: 0,
            // top: 100,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
              ),
            ))
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class ItemInfo extends StatelessWidget {
  const ItemInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            Icons.circle,
            size: 6,
          ),
        ),
        Text("Information Text - Nunito Regular 12").regularText(),
      ],
    );
  }
}

class OpeningHour extends StatelessWidget {
  final Schedule schedule;
  const OpeningHour({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = schedule.dayname ?? "";
    String dayName = '';
    if (name.length > 3) {
      dayName = name[0];
      dayName += name[1];
      dayName += name[2];
    }
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: Text(
                dayName,
                style: TextStyle(color: Colors.white),
              )),
            ),
            Text('${schedule.startTime} - ${schedule.endTime}'),
          ],
        ),
      ),
    );
  }
}
