import 'package:boilerplate_flutter/page/login/forgot_pass.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../widget/popup/bottom_sheet.dart';
import '../boarding_page/thirdboardingpage.dart';
import '../term_and_condition/term_and_cond.dart';

class EmailVerificationSuccess extends StatelessWidget {
  const EmailVerificationSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 88,
            ),
            Center(
              child: SvgPicture.asset("assets/ic/ic_email_diverifikasi.svg"),
            ),
            const SizedBox(
              height: 16,
            ),
            Text("Email Berhasil Di Verifikasi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: OTextPrimaryColor)),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 52.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Anda dapat menggunakan alamat Email untuk masuk kedalam aplikasi serta menerima informasi dari OneMedix', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                  // style: DefaultTextStyle.of(context).style,
                  // children: <TextSpan>[
                  //   TextSpan(text: 'abcde123@gmail.com ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff2D79F6))),
                  //   TextSpan(
                  //     text: 'untuk dapat melanjutkan proses pendaftaran akun',
                  //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                  //   ),
                  //   // TextSpan(text: ' world!'),
                  // ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: BaseButton(
                text: "LANJUT",
                textColor: Colors.white,
                color: OprimaryColor,
                ontap: () {
                  // bottomSheetWidget(heightFactor: 0.8, context: context, child: TandCPage());
                  Get.to(const ThirdboardingPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
