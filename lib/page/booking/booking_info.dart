// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:boilerplate_flutter/page/book_controller.dart';
import 'package:boilerplate_flutter/page/tournament/tournament_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/product/product.dart';
import 'package:boilerplate_flutter/model/product/schedule.dart';
import 'package:boilerplate_flutter/model/tournament/create_data_tournamert.dart';
import 'package:boilerplate_flutter/page/booking/booking_date.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';

import '../../model/place/place_res.dart';
import '../../widget/base/button/button_bar.dart';
import '../../widget/extention/base_ext.dart';

class BookingInfo extends StatefulWidget {
  final Place item;
  const BookingInfo({Key? key, required this.item}) : super(key: key);

  @override
  State<BookingInfo> createState() => _BookingInfoState();
}

class _BookingInfoState extends State<BookingInfo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final cGlobal = Get.find<GlobalController>();

  final cBook = Get.find<BookController>();
  final cTournament = Get.put(TournamentController());
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
                  delegate: MySliverAppBar(
                      image: widget.item.getImageUrl(), expandedHeight: 300),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.item.name).titleText(),
                                          Container(
                                              width: 65,
                                              child: BaseButton(
                                                ontap: () {},
                                                text: "0,1 Km",
                                                color: Color(0xff19204E),
                                                outlineRadius: 15,
                                                height: 28,
                                              ))
                                        ],
                                      ),
                                      Text(widget.item.region.name),
                                      Obx(
                                        () => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const SizedBox(height: 5),
                                              (listProduct.isNotEmpty)
                                                  ? Text(listProduct.first.price
                                                          .toCurrency())
                                                      .pageTitleText()
                                                  : Container(),
                                            ]),
                                      ),
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
                                        labelStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                        unselectedLabelStyle: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                        isScrollable: true,
                                        indicatorColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 28,
                                                      vertical: 21),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Facilities")
                                                      .fieldTitleText(),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  const ItemInfo(
                                                      info: "Parking Spot"),
                                                  const ItemInfo(
                                                      info: "Changing Rooms"),
                                                  const ItemInfo(
                                                      info: "Cafetaria"),
                                                  const ItemInfo(
                                                      info: "Cafetaria"),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Obx(
                                                  () => Container(
                                                    child: (loading.value)
                                                        ? const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: SizedBox(
                                                              height: 35,
                                                              child: ListView
                                                                  .builder(
                                                                      // shrinkWrap:
                                                                      //     true,
                                                                      scrollDirection:
                                                                          Axis
                                                                              .horizontal,
                                                                      itemCount:
                                                                          listProduct
                                                                              .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 8,
                                                                              right: 12),
                                                                          child:
                                                                              InkWell(
                                                                            onTap:
                                                                                () {
                                                                              listSchedule.value = listProduct[index].schedules;
                                                                              selectProduct.value = index;
                                                                              log("select produck");
                                                                              cBook.selectProduct.clear();
                                                                              cBook.selectProduct.add(listProduct[index]);
                                                                              // widget.createData?.product = listProduct[index];
                                                                            },
                                                                            child:
                                                                                Obx(
                                                                              () {
                                                                                bool isSelect = false;
                                                                                //todo cek apakah produk sudah dipilih
                                                                                if (cBook.selectProduct.isNotEmpty) {
                                                                                  //todo cek apakah produk yang sudah dipilih = data index
                                                                                  if (cBook.selectProduct.first.id == listProduct[index].id) {
                                                                                    isSelect = true;
                                                                                  }
                                                                                }
                                                                                return Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: isSelect ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primaryContainer,
                                                                                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                                                                                    child: Center(
                                                                                      child: Text(listProduct[index].name).fieldTitleText().white(),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
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
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          listSchedule.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return OpeningHour(
                                                          schedule:
                                                              listSchedule[
                                                                  index],
                                                          // createData: widget.createData,
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
        bottomNavigationBar: Obx(
          () => OButtonBar(
              title: "BOOK NOW",
              isEnable: (cBook.selectProduct.isNotEmpty),
              onPressed: () {
                // cBook.product = listProduct[selectProduct.value];
                cTournament.tournamentdata.product =
                    listProduct[selectProduct.value].id;
                log(cTournament.tournamentdata.name.toString());
                log(cTournament.tournamentdata.drawSize.toString());
                log(cTournament.tournamentdata.tournamentFormat.toString());
                log(cTournament.tournamentdata.matchFormat.toString());
                log(cTournament.tournamentdata.product.toString());
                Get.to(BookingDate(
                  product: cBook.selectProduct.first,
                ));
              }),
        ));
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
  final String info;
  const ItemInfo({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.circle,
                size: 6,
              ),
            ),
            Text(info).regularText(),
          ],
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}

class OpeningHour extends StatelessWidget {
  CreateDataTournament? createData;
  final Schedule schedule;
  OpeningHour({
    Key? key,
    this.createData,
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
                style: const TextStyle(color: Colors.white),
              )),
            ),
            Text('${schedule.startTime} - ${schedule.endTime}'),
          ],
        ),
      ),
    );
  }
}
