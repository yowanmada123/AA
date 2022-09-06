import 'package:boilerplate_flutter/page/login/email_verification/email_verification_success.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';

class EmailVerificationSent extends StatelessWidget {
  const EmailVerificationSent({Key? key}) : super(key: key);

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
              child: SvgPicture.asset("assets/ic/ic_email_dikirim.svg"),
            ),
            const SizedBox(
              height: 16,
            ),
            Text("Email Verifikasi Telah Dikirim ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: OTextPrimaryColor)),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Silakan klik verifikasi didalam Email yang sudah dikirim ke ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                  // style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'abcde123@gmail.com ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff2D79F6))),
                    TextSpan(
                      text: 'untuk dapat melanjutkan proses pendaftaran akun',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                    // TextSpan(text: ' world!'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: BaseButton(
                text: "BUKA APLIKASI EMAIL",
                textColor: Colors.white,
                color: OprimaryColor,
                ontap: () {
                  Get.to(const EmailVerificationSuccess());
                },
              ),
            ),
            const SizedBox(
              height: 85,
            ),
            const Text(
              "Tidak menerima Email verifikasi ",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text("Kirim ulang Email verifikasi ?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff2D79F6))),
          ],
        ),
      ),
    );
  }
}
