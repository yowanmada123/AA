import 'dart:developer';

import 'package:boilerplate_flutter/page/booking/booking_date.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
// import 'package:boilerplate_flutter/pages/booking/list_user_page.dart';


import 'package:boilerplate_flutter/widget/base/map.dart';
import 'package:boilerplate_flutter/widget/base/map_openstreet.dart';
import 'package:boilerplate_flutter/widget/base/square_button.dart';
import 'package:boilerplate_flutter/widget/base/button_bar.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';

import 'package:boilerplate_flutter/widget/form/form_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/base/scaffold.dart';

class ChoseLocation extends StatefulWidget {
  final String isFrom;
  const ChoseLocation({Key? key, required this.isFrom}) : super(key: key);

  @override
  State<ChoseLocation> createState() => _ChoseLocationState();
}

class _ChoseLocationState extends State<ChoseLocation> {
  final gstate = Get.find<GlobalController>();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController alamat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "Maps",
      body: SingleChildScrollView(
        child:
        Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
          BaseMapOpenStreet(
            onChanged: (val) {
              log(val);
              setState(() {
                alamat.text = val;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 12.0),
            child: Form(
              key: _key,
              child: BaseFormText(
                title: "Description Title - Nunito Bold 16",
                controller: alamat,
                maxLines: 2,
              ),
            ),
          ),
          const SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.only(left:16.0,),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("ADDRESS DETAILS", style: TextStyle(color: Color(0xFFFF0000)),).informationText(),
                  ],
                ),

              ],
            ),
          )
          ],
        )
      ),
      bottomNavigationBar: OButtonBar(
          title: "SAVE LOCATION",
          color: const Color(0xFF21005D),
          // Theme.of(context).colorScheme.onPrimaryContainer,
          onPressed: () {
            // Get.to(BookingDate());
          }),
    );
  }
}