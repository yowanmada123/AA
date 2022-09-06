import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../widget/base/button/button_base.dart';

class SecondBoardingPage extends StatelessWidget {
  const SecondBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OprimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset("assets/bg/bg_top.png")),
            Positioned(
              bottom:0,
              right:0,
              child: Image.asset("assets/bg/bg_bottom.png")),
            Positioned(
              child:
              Padding(
                padding: const EdgeInsets.only(top:68.0, left: 18,right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Image.asset("assets/ic/OM2icon.png"),
                        // ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("One",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800, color: Colors.white)),
                            Text("Medix",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const Text("Kebutuhan olahraga Anda dalam satu genggaman",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800, color: Colors.white)),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Penjadwalan Vaksin, Rapid Tes Antibodi, rapid Test Antigen, RT-PCR dan", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white)),
                    
                  ],
                ),
              ), 
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BaseButton(text: "MASUK DENGAN EMAIL", textColor: OprimaryColor,color: Colors.white, ontap: () {}, image: "assets/ic/ic_mail.png",),
                    const SizedBox(
                      height: 16,
                    ),
                    BaseButton( text: "MASUK DENGAN GOOGLE",image: "assets/ic/ic_google.png", ontap: () {}, textColor: Colors.white,),
                    const SizedBox(
                      height: 16,
                    ),
                    BaseButton( image: "assets/ic/ic_apple1.png",text: "MASUK DENGAN APPLE ID", color: Color(0xff202B36), ontap: () {
                      // Get.to(page)
                    }, textColor: Colors.white,),
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
