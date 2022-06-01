import 'package:boilerplate_flutter/page/kyc/kyc_form.dart';
import 'package:boilerplate_flutter/widget/button.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ListProfil extends StatefulWidget {
  const ListProfil({Key? key}) : super(key: key);

  @override
  State<ListProfil> createState() => _ListProfilState();
}

class _ListProfilState extends State<ListProfil> {
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
          OButton(title: "Tambah User", onPressed: () {}),
          Expanded(
              child: ListView(
            children: [],
          )),
        ],
      ),
    );
  }
}