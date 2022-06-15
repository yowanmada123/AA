// import 'dart:developer';

// import 'package:farmalab_mobile/global_controller.dart';
// import 'package:farmalab_mobile/pages/booking/list_user_page.dart';
// import 'package:farmalab_mobile/widget/base/alertx.dart';
// import 'package:farmalab_mobile/widget/base/base_map.dart';
// import 'package:farmalab_mobile/widget/base/base_map_openstreet.dart';
// import 'package:farmalab_mobile/widget/base/base_scaffold.dart';
// import 'package:farmalab_mobile/widget/base/square_button.dart';
// import 'package:farmalab_mobile/widget/form/form_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ChoseLocation extends StatefulWidget {
//   final String isFrom;
//   const ChoseLocation({Key? key, required this.isFrom}) : super(key: key);

//   @override
//   State<ChoseLocation> createState() => _ChoseLocationState();
// }

// class _ChoseLocationState extends State<ChoseLocation> {
//   final gstate = Get.find<GlobalController>();
//   GlobalKey<FormState> _key = GlobalKey<FormState>();
//   TextEditingController alamat = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return BaseScaffold(
//       title: "Lokasi",
//       body: ListView(
//         children: [
//           BaseMapOpenStreet(
//             onChanged: (val) {
//               log(val);
//               setState(() {
//                 alamat.text = val;
//               });
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Form(
//               key: _key,
//               child: BaseFormText(
//                 title: "ALAMAT DETAIL",
//                 controller: alamat,
//                 maxLines: 3,
//               ),
//             ),
//           ),
//           SquareButton(
            
//               title: "SIMPAN LOKASI",
              
//               onPressed: () {
//                 if (_key.currentState!.validate()) {
//                   if (gstate.latitude == 0.0) {
//                     Alertx().error("Tunggu..");
//                   } else {
//                     setState(() {
//                       gstate.addres = alamat.text;
//                     });

//                     log(gstate.addres);
//                     log(gstate.longitude.toString());
//                     log(gstate.latitude.toString());
                    
//                     Get.to(ListUserPage(
//                       isMultiple: true,
//                       isFrom: widget.isFrom,
//                     ));
//                   }
//                 }
//               })
//         ],
//       ),
//     );
//   }
// }