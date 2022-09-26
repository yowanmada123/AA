import 'dart:developer';

import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/model/place/region_res.dart';
import 'package:boilerplate_flutter/page/book_controller.dart';
import 'package:boilerplate_flutter/page/booking/booking_date.dart';
import 'package:boilerplate_flutter/page/booking/booking_info.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
// import 'package:boilerplate_flutter/pages/booking/list_user_page.dart';

import 'package:boilerplate_flutter/widget/base/map/map.dart';
import 'package:boilerplate_flutter/widget/base/map/map_openstreet.dart';
import 'package:boilerplate_flutter/widget/base/button/button_oval.dart';
import 'package:boilerplate_flutter/widget/base/button/button_bar.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';

import 'package:boilerplate_flutter/widget/base/form/form_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/base/form/form_scaffold.dart';

class ChoseLocation extends StatefulWidget {
  Place? item;
  ChoseLocation({
    Key? key,
    this.item,
  }) : super(key: key);

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
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BaseMapOpenStreet(
            onChanged: (val) {
              setState(() {
                alamat.text = val.address;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 12.0),
            child: Form(
              key: _key,
              child: OBaseFormText(
                title: "Description Title - Nunito Bold 16",
                controller: alamat,
                maxLines: 2,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "ADDRESS DETAILS",
                      style: TextStyle(color: Color(0xFFFF0000)),
                    ).informationText(),
                  ],
                ),
              ],
            ),
          )
        ],
      )),
      bottomNavigationBar: OButtonBar(
          title: "SAVE LOCATION",
          color: const Color(0xFF21005D),
          // Theme.of(context).colorScheme.onPrimaryContainer,
          onPressed: () {
            log(widget.item.toString());
           
            Get.to(BookingInfo(
              item: widget.item ??
                  Place(
                      address: "",
                      description: '',
                      id: '',
                      images: '',
                      latitude: 0,
                      longitude: 0,
                      name: '',
                      region: Region(id: "", name: '', type: '')),
            ));
          }),
    );
  }
}
