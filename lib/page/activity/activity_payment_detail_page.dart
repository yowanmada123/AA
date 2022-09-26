import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/ext_text.dart';
import 'package:boilerplate_flutter/widget/popup/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DetailPaymentActivityPage extends StatefulWidget {
  const DetailPaymentActivityPage({super.key});

  @override
  State<DetailPaymentActivityPage> createState() => _DetailPaymentActivityPageState();
}

class _DetailPaymentActivityPageState extends State<DetailPaymentActivityPage> {
  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "Detail Pembayaran",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("KODE QR").gray().fieldTitleText(),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: (){
                bottomSheetWidget(heightFactor: 0.8, context: context, 
                  child: 
                    Column(
                      children: [
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Icon(Icons.close)),
                              Text("Kode QR").pageTitleText().black(),
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: Icon(Icons.check))
                            ],
                        ),
                        ),
                        SvgPicture.asset("assets/ic/ic_qr_large.svg")
                      ]
                    )
                );
              },
              child: Row(children: [
                SvgPicture.asset("assets/ic/ic_qr_big.svg"),
                const SizedBox(
                width: 8,
                ),
                Container(
                  width: 164,
                  child: const Text("TAP UNTUK MEMPERBESAR QR BOOKING").red().fieldTitleText())
              ],),
            ),
            const SizedBox(
              height: 48,
            ),
            const Text("KODE BOOKING").red().fieldTitleText(),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text("ABCDE1234567890").black().regularText(),
                const SizedBox(
                width: 8,
                ),
                const Text("LIHAT DETAIL").red().fieldTitleText(),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const Text("JENIS LAYANAN").red().fieldTitleText(),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SvgPicture.asset("assets/ic/ic_burble_red.svg"),
                const SizedBox(
                width: 15,
                ),
                const Text("Training").black().pageTitleText(),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Text("VENUE DETAILS").red().fieldTitleText(),
            const SizedBox(
              height: 13,
            ),
            const Text("LAPANGAN TENNIS SENAYAN").black().fieldTitleText(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SvgPicture.asset("assets/ic/ic_location_primary.svg"),
                const SizedBox(
                width: 8,
                ),
                const Text("Jakarta, Indonesia").black().descriptionText(),
              ],
            ),
            const SizedBox(
              height: 46,
            ),
            const Text("TRAINER DETAILS").red().fieldTitleText(),  
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                   backgroundImage: AssetImage("assets/images/trainer1.png"),
                ),
                SvgPicture.asset("assets/ic/ic_location_primary.svg"),
                const SizedBox(
                width: 8,
                ),
                const Text("Jakarta, Indonesia").black().descriptionText(),
              ],
            ),
            const SizedBox(
              height: 44,
            ),
            const Text("SCHEDULE DETAILS").red().fieldTitleText(),  
            const SizedBox(
              height: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  SvgPicture.asset("assets/ic/ic_calender_19.svg"),
                  const SizedBox(
                  width: 17,
                  ),
                  const Text("3 Februari 2022").black().descriptionText(),
                ],),
                const Text("11:00 AM - 01:00 PM").black().descriptionText(),
              ],
            ),
             const SizedBox(
              height: 51,
            ),
            const Text("BOOKINF FOR").red().fieldTitleText(),  
            const SizedBox(
              height: 13,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: OprimaryColor,
                  radius: 20,
                  child: CircleAvatar(
                    backgroundColor: OprimaryColor,
                    radius: 19,
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 13,
                  ),
                const Text("Stephen Strange (Me)").black().regularBigText(),  
              ],
            ),
            const SizedBox(
              height: 21,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[350],
                  radius: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 19,
                    child: Icon(
                      Icons.person_outline_rounded,
                      color: OprimaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 13,
                  ),
                const Text("Tony Stark").black().regularBigText(),  
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            BaseButton(ontap: (){}, text: "BATALKAN PESANAN", outlineRadius: 8, color: OTextsecondaryColor, textColor: Colors.white,),
            const SizedBox(
              height: 13,
            ),
            BaseButton(ontap: (){}, text: "BATALKAN PESANAN", outlineRadius: 8, color: OTextsecondaryColor, textColor: Colors.white,),
            const SizedBox(
              height: 44,
            ),
          ],
        ),
      ),
    );
  }
}