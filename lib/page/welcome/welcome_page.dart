import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../login/splashscreen.dart';

class WelcomingPage extends StatelessWidget {
  const WelcomingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
            onTap: ()=> Get.to(const SplashScreenPage()),
            child: Stack(
              children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: Image.asset("assets/bg/bg.jpg", fit: BoxFit.cover,)),
                    Container(
                      width: Get.width,
                      height: Get.height,
                      color: const Color.fromARGB(255, 98, 98, 98).withOpacity(0.4),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: Get.width,
                        height: Get.height,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:28.0, left: 23),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                Row(
                                  children: [
                                    Image.asset("assets/ic/OMicon.png"),
                                  ],
                                ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("One",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800, color: Colors.white)),
                                  Text("Event",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800, color: Colors.white)),
                                ],
                              ),
                              ],),
                            ),
                            const SizedBox(
                                      height: 163,
                                    ),
                            Padding(
                              padding: const EdgeInsets.only(left:17.0),
                              child: Column(
                                children: const [
                                  Text("Kebutuhan perjalanan umrah Anda dalam satu genggaman",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800, color: Colors.white)),
                                  SizedBox(
                                      height: 8,
                                    ),
                                  Text("Melayani persiapan perjalanan umrah Anda dari awal pembayaran sampai rencana di tempat tujuan nanti",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400, color: Colors.white)),
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    )
                  ],
                ),
          )),
    );
  }
}
