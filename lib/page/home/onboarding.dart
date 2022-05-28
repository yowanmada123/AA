import 'package:boilerplate_flutter/page/login/login.dart';
import 'package:boilerplate_flutter/page/login/register.dart';
import 'package:boilerplate_flutter/widget/button.dart';
import 'package:boilerplate_flutter/widget/dummy/logo.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/popup/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/bg/bg_home.svg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LogoDummy(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Title Text",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ).titleText(),
                      Text(
                        "Nunito Bold 24",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ).titleText(),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Text",
                        style: TextStyle(color: Colors.white),
                      ).regularText(),
                      Text(
                        "Nunito regular 12",
                        style: TextStyle(color: Colors.white),
                      ).regularText(),
                      SizedBox(
                        height: 100,
                      ),
                      OButton(
                          title: "Login",
                          onPressed: () {
                            bottomSheetWidget(
                                heightFactor: 0.8,
                                context: context,
                                child: LoginPage());
                          }),
                      SizedBox(
                        height: 18,
                      ),
                      OButton(
                          color: Theme.of(context).colorScheme.onPrimary,
                          textColor: Theme.of(context).colorScheme.primary,
                          title: "Button 1 - Nunito bold 14 Register ",
                          onPressed: () {
                            bottomSheetWidget(
                                heightFactor: 0.8,
                                context: context,
                                child: RegisterPage());
                          }),
                      Divider(
                        color: Colors.white,
                      ),
                      OButton(
                        title: "Button 1 - Nunito bold 14 ",
                        onPressed: () {},
                        icon: Image.asset("assets/ic/ic_google.png"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
