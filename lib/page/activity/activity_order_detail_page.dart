import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/ext_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailActivityOrderPage extends StatefulWidget {
  const DetailActivityOrderPage({super.key});

  @override
  State<DetailActivityOrderPage> createState() => _DetailActivityOrderPageState();
}

class _DetailActivityOrderPageState extends State<DetailActivityOrderPage> {
  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "Detail Pemesanan",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("STATUS PEMBAYARAN").gray().fieldTitleText(),
            const SizedBox(
              height: 16,
            ),
            const Text("SUKSES").red().fieldTitleText(),
            const SizedBox(
              height: 24,
            ),
            const Text("TANGGAL & WAKTU PEMBAYARAN").gray().fieldTitleText(),
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              SvgPicture.asset("assets/ic/ic_calendar_red_outline.svg"),
              const SizedBox(
              width: 8,
              ),
              const Text("Jum'at, 03/02/2022, 11:00 PM").black().regularText()
            ],),
            const SizedBox(
              height: 24,
            ),
            const Text("KODE PEMBAYARAN").gray().fieldTitleText(),
            const SizedBox(
              height: 16,
            ),
            const Text("ABCDE1234567890").black().regularText(),
            const SizedBox(
              height: 24,
            ),
            const Text("JENIS PEMBAYARAN").gray().fieldTitleText(),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
              SvgPicture.asset("assets/ic/ic_calender_red.svg"),
              const SizedBox(
              width: 14,
              ),
              const Text("Booking").black().pageTitleText()
            ],),
            const SizedBox(
              height: 24,
            ),
            const Text("NOMINAL PEMBAYARAN").gray().fieldTitleText(),
            const SizedBox(
              height: 16,
            ),
            const Text("Rp7.000.000", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), ),
            const SizedBox(
              height: 24,
            ),
            const Text("METODE PEMBAYARAN").gray().fieldTitleText(),
            const SizedBox(
              height: 16,
            ),
            const Text("BNI Virtual Account").black().regularBigText(),
            const SizedBox(
              height: 24,
            ),
            const Text("PEMBAYARAN UNTUK").gray().fieldTitleText(),
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              Icon(Icons.person_outline_rounded, color: OprimaryColor,),
              const SizedBox(
              width: 2,
              ),
              const Text("Stephen Strange").black().regularText()
            ],),
          ],
        ),
      ),
    );
  }
}