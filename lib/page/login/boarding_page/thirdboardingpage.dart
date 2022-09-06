import 'package:boilerplate_flutter/page/login/login.dart';
import 'package:boilerplate_flutter/page/login/boarding_page/secondboardingpage.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';

import '../../../utils/colors.dart';
import '../../../widget/base/button/button_base.dart';
import '../../../widget/popup/bottom_sheet.dart';

class ThirdboardingPage extends StatelessWidget {
  const ThirdboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OprimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 0, right: 0, child: Image.asset("assets/bg/bg_top.png")),
            Positioned(bottom: 0, right: 0, child: Image.asset("assets/bg/bg_bottom.png")),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(top: 68.0, left: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/ic/OM2icon.png"),
                        // ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("One", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                            Text("Medix", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Kebutuhan olahraga Anda dalam satu genggaman", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Positioned(
              // bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BaseButton(
                      text: "MASUK DENGAN WHATSAPP",
                      color: const Color(0xff3EA69B),
                      image: "assets/ic/ic_whatsapp.png",
                      ontap: () {
                        
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.white))),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text("atau").white(),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.white))),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BaseButton(
                      text: "MASUK DENGAN GOOGLE",
                      image: "assets/ic/ic_google.png",
                      ontap: () {},
                      textColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BaseButton(
                      text: "MASUK",
                      color: Colors.white,
                      ontap: () {
                        bottomSheetWidget(heightFactor: 0.8, context: context, child: const LoginPage());
                        // Get.to(const SecondBoardingPage());
                      },
                      textColor: OprimaryColor,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
