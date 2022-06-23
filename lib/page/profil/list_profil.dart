import 'package:boilerplate_flutter/all_screen.dart';
import 'package:boilerplate_flutter/page/booking/booking_list.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/kyc/kyc_edit_form.dart';
import 'package:boilerplate_flutter/page/kyc/kyc_form.dart';
import 'package:boilerplate_flutter/page/kyc/kyc_list.dart';
import 'package:boilerplate_flutter/page/transaction/transaction_list.dart';
import 'package:boilerplate_flutter/widget/button.dart';
import 'package:boilerplate_flutter/widget/button_bar.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      body: Column(
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
          // OButton(title: "Tambah User", onPressed: () {}),
          Expanded(
              child: ListView(
            children: [],
          )),
        ],
      ),
      bottomNavigationBar: OButtonBar(
          title: "Logout",
          onPressed: () async {
            _handleSignOut();
            cGlobal.setToken("");
            Get.offAll(AllScreen());
          }),
    );
  }
}
