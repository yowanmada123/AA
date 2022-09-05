import 'package:boilerplate_flutter/page/login/login.dart';
import 'package:boilerplate_flutter/page/login/onboardingpage.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  int splashtime = 3;
  @override
  void initState() {
    Future.delayed(Duration(seconds: splashtime), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const OnboardingPage();
      }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Image.asset("assets/ic/OM1icon.png"),
            // ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("One",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800, color: Colors.black87)),
                Text("Medix",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800, color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

