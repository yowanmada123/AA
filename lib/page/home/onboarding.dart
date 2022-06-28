import 'dart:developer';

import 'package:boilerplate_flutter/page/login/login.dart';
import 'package:boilerplate_flutter/page/login/register.dart';
import 'package:boilerplate_flutter/page/login/register_controller.dart';
import 'package:boilerplate_flutter/widget/base/alertx.dart';
import 'package:boilerplate_flutter/widget/base/button.dart';
import 'package:boilerplate_flutter/widget/dummy/logo.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/popup/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  GoogleSignInAccount? _currentUser;
  GoogleSignInAuthentication? googleAuth;
  final cOnboarding = Get.put(RegisterController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
      setState(() {
        _currentUser = account;
        // Alertx().error(account!.authentication);
      });
      if (_currentUser != null) {
        googleAuth = await _currentUser!.authentication;
        // Alertx().error(googleAuth.accessToken);
        if (googleAuth != null) {
          log("google token = ${googleAuth!.accessToken.toString()}");
          cOnboarding.loginByGoogle(googleAuth!.accessToken.toString());
        }

        // _handleGetContact(_currentUser!);
      } else {
        if (googleAuth != null) {
          log("google token else = ${googleAuth!.accessToken.toString()}");
          cOnboarding.loginByGoogle(googleAuth!.accessToken.toString());
        }
      }
    });
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Future<void> _handleSignOut() => _googleSignIn.disconnect();
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();

      // Alertx().error(_currentUser!.email);
      // Alertx().error(_currentUser!.displayName);

      // final googleAuth = await _currentUser!.authentication;
      // Alertx().error(googleAuth.accessToken);
      // log("google token = ${googleAuth.accessToken.toString()}");
    } catch (error) {
      Alertx().error(error.toString());
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                              bottomSheetWidget(heightFactor: 0.8, context: context, child: LoginPage());
                            }),
                        SizedBox(
                          height: 18,
                        ),
                        OButton(
                            color: Theme.of(context).colorScheme.onPrimary,
                            textColor: Theme.of(context).colorScheme.primary,
                            title: "Button 1 - Nunito bold 14 Register ",
                            onPressed: () {
                              bottomSheetWidget(heightFactor: 0.8, context: context, child: RegisterPage());
                            }),
                        Divider(
                          color: Colors.white,
                        ),
                        OButton(
                          title: "Login Google - Nunito bold 14 ",
                          onPressed: () {
                            _handleSignIn();
                          },
                          icon: Image.asset("assets/ic/ic_google.png"),
                        ),
                        SignInWithAppleButton(
                          onPressed: () async {
                            final credential = await SignInWithApple.getAppleIDCredential(
                              scopes: [
                                AppleIDAuthorizationScopes.email,
                                AppleIDAuthorizationScopes.fullName,
                              ],
                            );

                            log(credential.toString());
                            log(credential.identityToken.toString());

                            // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                            // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // bottomNavigationBar: Container(
        //   color: Colors.transparent,
        //   child: OButton(
        //       title: "Keluar dari google sign in",
        //       onPressed: () {
        //         _handleSignOut();
        //       }),
        // ),
      );
    });
  }
}
