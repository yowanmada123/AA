import 'dart:developer';

import 'package:boilerplate_flutter/all_screen.dart';
import 'package:boilerplate_flutter/model/user/profile.dart';
import 'package:boilerplate_flutter/page/activity/activity_order_detail_page.dart';
import 'package:boilerplate_flutter/page/activity/activity_payment_detail_page.dart';
import 'package:boilerplate_flutter/page/booking/booking_list.dart';
import 'package:boilerplate_flutter/page/kyc/kyc_edit_form.dart';
import 'package:boilerplate_flutter/page/order/order_detail.dart';
import 'package:boilerplate_flutter/page/place/place_list.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';
import 'package:boilerplate_flutter/widget/base/button/button_small_outline.dart';
import 'package:boilerplate_flutter/widget/base/form/form_checkbox.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/base/form/form_search_widget.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../graphql_base.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool isEmpthy = false;
  final loading = true.obs;
  final listProfile = <Profile>[].obs;
  String query = '';
  @override
  void initState() {
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: OprimaryColor,
          title: const Text('Aktifitas').white().pageTitleText(),
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'ONGOING',
              ),
              Tab(
                text: 'COMPLETED',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            /////////////////////ONGOING////////////////
            isEmpthy
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/ic/ic_empthy_activity.svg"),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text("Aktivitas Kosong").black().titleText(),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(width: 257, child: const Text("Anda belum mempunyai aktifitas, silakan pilih pada halamam beranda", textAlign: TextAlign.center).black().regularBigText()),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    child: Container(
                      child: ListView(
                        children: [
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       flex: 1,
                          //       child: OButtonSmallOutline(
                          //         title: "Filter",
                          //         titleColor: OColorBrown,
                          //         icon: "assets/ic/ic_filter.svg",
                          //         onTap: () {
                          //           // ShowFilter(context);
                          //         },
                          //       ),
                          //     ),
                          //     Expanded(
                          //         flex: 1,
                          //         child: OButtonSmallOutline(
                          //           title: "Sort By",
                          //           titleColor: OColorBrown,
                          //           icon: "assets/ic/ic_sort.svg",
                          //           onTap: () {
                          //             // SortBy(context);
                          //           },
                          //         )),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 12,
                          // ),
                          GestureDetector(
                            onTap: (() => Get.to(const DetailActivityOrderPage())),
                            child: const ItemWaitingOrder(
                              iconSvg: "assets/ic/ic_burble_red.svg",
                              customer: "3 Orang",
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const ItemWaitingOrder(
                            iconSvg: "assets/ic/ic_calender_red.svg", customer: 'Stephen Strange',
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const ItemWaitingOrder(
                            iconSvg: "assets/ic/ic_trophy_red_bg.svg", customer: 'Yowanda',
                          ),
                        ],
                      ),
                    ),
                  ),
            /////////////////////COMPLETED////////////////
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Container(
                child: ListView(
                  children: [
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 1,
                    //       child: OButtonSmallOutline(
                    //         title: "Filter",
                    //         titleColor: OColorBrown,
                    //         icon: "assets/ic/ic_filter.svg",
                    //         onTap: () {
                    //           // ShowFilter(context);
                    //         },
                    //       ),
                    //     ),
                    //     Expanded(
                    //         flex: 1,
                    //         child: OButtonSmallOutline(
                    //           title: "Sort By",
                    //           titleColor: OColorBrown,
                    //           icon: "assets/ic/ic_sort.svg",
                    //           onTap: () {
                    //             // SortBy(context);
                    //           },
                    //         )),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 12,
                    // ),
                    GestureDetector(
                      onTap: (() => Get.to(const DetailPaymentActivityPage())),
                      child: const ItemOrder(
                        isActive: true,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const ItemOrder(
                      isActive: false,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const ItemOrder(
                      isActive: false,
                    ),
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

class WaitingOrder extends StatefulWidget {
  const WaitingOrder({super.key});

  @override
  State<WaitingOrder> createState() => _WaitingOrderState();
}

class _WaitingOrderState extends State<WaitingOrder> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ItemOrder extends StatefulWidget {
  final bool isActive;
  const ItemOrder({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  State<ItemOrder> createState() => _ItemOrderState();
}

class _ItemOrderState extends State<ItemOrder> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget.isActive) ? 235 : 178,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 32,
            width: Get.width,
            decoration: BoxDecoration(
                color: (widget.isActive) ? const Color(statusDone) : const Color(statusExpired),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                )),
            child: Center(child: (widget.isActive) ? const Text("Pembayaran Selesai").black().informationText() : const Text("Pembayaran Dibatalkan").black().informationText()),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(statusExpired),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset("assets/ic/ic_trophy_red.png")),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "TANGGAL & WAKTU",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ).gray(),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (widget.isActive) ? const Text("03/02/2022 11:00 - 13:00").black().regularText() : const Text("Rp 1.000.000").red().fieldTitleText(),
                          const Text("LIHAT DETAIL").red().fieldTitleText(),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "JENIS LAYANAN",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ).gray(),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text("Training").black().regularText(),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "PENJADWALAN UNTUK",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ).gray(),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text("3 Orang").black().regularText(),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          (widget.isActive)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44),
                  child: BaseButton(
                    height: 40,
                    ontap: () {
                      Get.to(OrderDetailPage());
                    },
                    iconSvg: "assets/ic/ic_qr.svg",
                    text: (widget.isActive) ? "BUKA QR BOOKING" : "CEK HASIL",
                    color: OTextsecondaryColor,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

class ItemWaitingOrder extends StatefulWidget {
  final String iconSvg;
  final String customer;
  const ItemWaitingOrder({
    Key? key,
    required this.iconSvg, required this.customer,
  }) : super(key: key);

  @override
  State<ItemWaitingOrder> createState() => _ItemWaitingOrderState();
}

class _ItemWaitingOrderState extends State<ItemWaitingOrder> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 229,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 32,
            width: Get.width,
            decoration: const BoxDecoration(
                color: Color(0xffFCEDB9),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                )),
            child: Center(
              child: const Text("Menunggu Pembayaran").black().informationText(),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(statusExpired),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(widget.iconSvg)),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "TANGGAL & WAKTU",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ).gray(),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("03/02/2022 11:00 - 13:00").black().regularText(),
                          const Text("LIHAT DETAIL").red().fieldTitleText(),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "JENIS LAYANAN",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ).gray(),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text("Training").black().regularText(),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "PENJADWALAN UNTUK",
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ).gray(),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(widget.customer).black().regularText(),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 44),
            child: BaseButton(
              height: 40,
              ontap: () {
                Get.to(OrderDetailPage());
              },
              text: "CARA PEMBAYARAN",
              color: OTextsecondaryColor,
            ),
          )
        ],
      ),
    );
  }
}
