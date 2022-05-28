import 'dart:developer';

import 'package:boilerplate_flutter/widget/button_bar.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/title_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TandCPage extends StatefulWidget {
  const TandCPage({Key? key}) : super(key: key);

  @override
  _TandCPageState createState() => _TandCPageState();
}

class _TandCPageState extends State<TandCPage> {
  bool accept = false;
  String dataTnC = "";
  String dataVersion = "";
  String dataTime = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TitleHeader(
          title: "Syarat Dan Ketentuan",
        ),
        if (dataTnC.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Version $dataVersion").titleText(),
                Text("Updated }").informationText(),
              ],
            ),
          ),
        Divider(
          thickness: 2,
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: (dataTnC.isEmpty)
                  ? Center(child: CircularProgressIndicator())
                  : Text("aa")), // Html(data: dataTnC)),
        ),
        CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              "Saya telah membaca, memahami dan menyetujui syarat dan ketentuan.",
            ),
            value: accept,
            onChanged: (val) {
              setState(() {
                accept = val!;
              });
            }),
        OButtonBar(
          title: "LANJUT",
          onPressed: () async {
            // if (res != null) {
            //   Get.to(EmailSentPage(
            //     email: widget.email,
            //     password: widget.password,
            //   ));
            // }
            // if (accept) {
            //   final c = Get.find<SignUpController>();
            //   await c.signUpEmail();
            // }
          },
          // color: Color((accept) ? primaryDark : greyLight),
          textColor: Colors.white,
        ),
      ],
    );
  }
}
