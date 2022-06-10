import 'package:boilerplate_flutter/page/booking/booking_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../widget/button_bar.dart';
import '../../widget/extention/base_ext.dart';

class BookingInfo extends StatefulWidget {
  const BookingInfo({Key? key}) : super(key: key);

  @override
  State<BookingInfo> createState() => _BookingInfoState();
}

class _BookingInfoState extends State<BookingInfo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: MySliverAppBar(expandedHeight: 300),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Lapangan Tenis Senayan').titleText(),
                                    Text('0,1 Km')
                                  ],
                                ),
                                Text('Jakarta, Indonesia'),
                                const SizedBox(height: 20),
                                Text(
                                    'Kompleks Gelora Bung Karno Unit 4 (Jalan Asia Afrika) Jakarta, DKI Jakarta 10270, Indonesia'),
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
                                  indicatorColor:
                                      Theme.of(context).colorScheme.primary,
                                  onTap: (index) {
                                    // Tab index when user select it, it start from zero
                                  },
                                  tabs: [
                                    Tab(
                                      text: "Page Subtitle - Nunito Bold 12",

                                      // child:
                                      //     Text("Page Subtitle - Nunito Bold 12")
                                      //         .fieldTitleText()
                                      //         .black(),
                                    ),
                                    Tab(
                                      text: "Page Subtitle - Nunito Bold 12",
                                      // child:
                                      //     Text("Page Subtitle - Nunito Bold 12")
                                      //         .fieldTitleText()
                                      //         .black(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 400,
                                  child: TabBarView(
                                    children: [
                                      ListView(
                                        children: [
                                          Text("Page Subtitle - Nunito Bold 12")
                                              .fieldTitleText(),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          ItemInfo(),
                                          ItemInfo(),
                                          ItemInfo(),
                                          ItemInfo(),
                                        ],
                                      ),
                                      ListView(
                                        children: [
                                          OpeningHour(),
                                          OpeningHour(),
                                          OpeningHour(),
                                          OpeningHour(),
                                          OpeningHour(),
                                          OpeningHour(),
                                          OpeningHour(),
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
          )
        ],
      ),
      bottomNavigationBar: OButtonBar(
          title: "BOOK NOW",
          onPressed: () {
            Get.to(BookingDate());
          }),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      // overflow: Overflow.visible,
      children: [
        Image.asset(
          "assets/sample/image_main.png",
          width: double.infinity,
          height: 100,
          fit: BoxFit.cover,
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
                        padding: const EdgeInsets.all(20.0),
                        child: SvgPicture.asset("assets/ic/ic_back.svg"),
                      ),
                    ),
                    // Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SvgPicture.asset("assets/ic/ic_bookmark.svg"),
                    ),
                  ],
                ),
              ),
            )),
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
  const OpeningHour({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
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
              'Mon',
              style: TextStyle(color: Colors.white),
            )),
          ),
          Text('08.00 - 09.00'),
        ],
      ),
    );
  }
}
