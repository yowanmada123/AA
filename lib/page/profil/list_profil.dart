import 'package:boilerplate_flutter/all_screen.dart';
import 'package:boilerplate_flutter/page/booking/booking_list.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/kyc/kyc_form.dart';
import 'package:boilerplate_flutter/page/kyc/kyc_list.dart';
import 'package:boilerplate_flutter/page/maps/maps_open_street.dart';
import 'package:boilerplate_flutter/page/place/place_list.dart';
import 'package:boilerplate_flutter/page/region/region_list_with_pull_to_req.dart';
import 'package:boilerplate_flutter/page/transaction/transaction_list.dart';
import 'package:boilerplate_flutter/widget/base/alertx.dart';
import 'package:boilerplate_flutter/widget/base/button/button.dart';
import 'package:boilerplate_flutter/widget/base/button/button_bar.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../region/region_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cGlobal = Get.find<GlobalController>();
  GoogleSignInAccount? _currentUser;
  GoogleSignInAuthentication? googleAuth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil").pageTitleText()),
      body: ListView(
        children: [
          OButton(
              title: "Lengkapi Profil",
              onPressed: () {
                Get.to(KYCFormPage());
              }),
          // OButton(
          //     title: "Edit Profil",
          //     onPressed: () {
          //       Get.to(KYCEditFormPage());
          //     }),
          OButton(
              title: "List Profil",
              onPressed: () {
                Get.to(KycList());
              }),
          OButton(
              title: "Booking",
              onPressed: () {
                Get.to(const BookingListPage());
              }),
          OButton(
              title: "List Transaction",
              onPressed: () {
                Get.to(const TransactionListPage());
              }),
          OButton(
              title: "List Region",
              onPressed: () {
                Get.to(RegionListPage());
              }),
          OButton(
              title: "List Region With Pull To Request",
              onPressed: () {
                Get.to(const RegionListWithPullToReqPage());
              }),
          OButton(
              title: "Maps",
              onPressed: () {
                Get.to(const ChoseLocation());
              }),
          OButton(
              title: "List Place",
              onPressed: () {
                Get.to(const PlaceListPage());
              }),
          // OButton(title: "Tambah User", onPressed: () {}),
          // Expanded(
          //     child: ListView(
          //   children: [],
          // )),
        ],
      ),
      bottomNavigationBar: OButtonBar(
        title: "Logout",
        onPressed: () async {
          Alertx().confirmDialog(
            title: "Logout", 
            desc: "Are you sure want to Logout ?", 
            onPressed: () {

          }, onPressed2: () {


          });
          // showDialog(
          //   barrierDismissible: true,
          //   context: context,
          //   builder: (c) => AlertDialog(
          //     title: Container(),
          //     content: Container(
          //       color: Colors.white,
          //       // height: 80,
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Text("Are You Sure Want To Logout ?"),
          //           Row(
          //             children: [
          //               InkWell(
          //                 onTap: () async {
          //                   Navigator.pop(context);
          //                 },
          //                 child: const Padding(
          //                   padding: EdgeInsets.all(8.0),
          //                   child: Text(
          //                     "No",
          //                   ),
          //                 ),
          //               ),
          //               InkWell(
          //                 onTap: () async {
          //                   _handleSignOut();
          //                   cGlobal.setToken("");
          //                   Get.offAll(AllScreen());
          //                 },
          //                 child: const Padding(
          //                   padding: EdgeInsets.all(8.0),
          //                   child: Text("Yes"),
          //                 ),
          //               )
          //             ],
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
