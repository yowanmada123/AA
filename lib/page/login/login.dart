import 'dart:developer';

import 'package:boilerplate_flutter/page/login/forgot_pass.dart';
import 'package:boilerplate_flutter/page/login/register_controller.dart';
import 'package:boilerplate_flutter/page/profil/list_profil.dart';
import 'package:boilerplate_flutter/widget/base/button/button_bar.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form/form.dart';
import 'package:boilerplate_flutter/widget/popup/bottom_sheet.dart';
import 'package:boilerplate_flutter/widget/base/form/form_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../widget/base/form/form_with_icon.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: GetBuilder<RegisterController>(
          init: RegisterController(),
          initState: (_) {},
          builder: (c) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: [
                          const OTitleHeader(
                            title: "Masuk",
                          ),
                          // OFormTextWithIcon(
                          //   title: "EMAIL",
                          //   controller: _emailController,
                          //   formType: FormType.email, icon: IconData(codePoint),
                          // ),
                          OFormText(
                            title: "EMAIL",
                            controller: _emailController,
                            formType: FormType.email,
                            icon: const IconData(0xf018, fontFamily: 'MaterialIcons'),
                          ),
                          OFormText(
                            title: "PASSWORD",
                            controller: _passwordController,
                            formType: FormType.password,
                            icon: const IconData(0xe3b1, fontFamily: 'MaterialIcons'),
                          ),
                          Center(
                            child: Padding(
                            padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                            child: InkWell(
                                onTap: () {
                                  bottomSheetWidget(heightFactor: 0.8, context: context, child: ForgotPassPage());
                                },
                                child: 
                                 
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                    text: 'Jika sudah masuk melalui Google sebelumnya silakan masuk lewat Google kembali ',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
                                    // style: DefaultTextStyle.of(context).style,
                                    children:  <TextSpan>[
                                      TextSpan(text: 'disini',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xff2D79F6))),
                                      // TextSpan(text: ' world!'),
                                    ],
                                  ),
                                )
                          ),
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),
                

                OButtonBar(
                  title: "LANJUT",
                  onPressed: () {
                    // Get.offAll(ListProfil());
                    if (_key.currentState!.validate()) {
                      c.email = _emailController.text;
                      c.password = _passwordController.text;
                      c.loginByEmail();
                      log("login");
                    }
                  },
                  // color: Color(primaryDark),
                  // textColor: Colors.white,
                ),
              ],
            );
          }),
    );
  }
}
