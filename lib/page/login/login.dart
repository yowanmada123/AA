import 'dart:developer';

import 'package:boilerplate_flutter/page/login/forgot_pass.dart';
import 'package:boilerplate_flutter/widget/button_bar.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/form.dart';
import 'package:boilerplate_flutter/widget/popup/bottom_sheet.dart';
import 'package:boilerplate_flutter/widget/title_form.dart';
import 'package:flutter/material.dart';

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
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              children: [
                 TitleHeader(
                  title: "Masuk",
                ),
                OFormText(
                  title: "EMAIL",
                  controller: _emailController,
                  formType: FormType.email,
                ),
                OFormText(
                  title: "PASSWORD",
                  controller: _passwordController,
                  formType: FormType.password,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                      onTap: () {
                        bottomSheetWidget(
                            heightFactor: 0.8,
                            context: context,
                            child: ForgotPassPage());
                      },
                      child: Text("Lupa Password ?").linkText()),
                ))
              ],
            ),
          ),
          OButtonBar(
            title: "LANJUT",
            onPressed: () {
              if (_key.currentState!.validate()) {
                // submit();
                log("login");
              }
            },
            // color: Color(primaryDark),
            // textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
