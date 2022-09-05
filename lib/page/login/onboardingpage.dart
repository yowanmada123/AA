import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/colors.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

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
                padding: const EdgeInsets.only(top:68.0, left: 18),
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
                  ],
                ),
              ), 
            ),
            Positioned(
              bottom: 200,
              child: Column(
                children: [
                  
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
