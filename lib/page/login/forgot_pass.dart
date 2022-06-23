import 'dart:developer';

import 'package:boilerplate_flutter/page/login/register.dart';
import 'package:boilerplate_flutter/widget/base/button_bar.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form.dart';
import 'package:boilerplate_flutter/widget/popup/bottom_sheet.dart';
import 'package:boilerplate_flutter/widget/base/title_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
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
                  title: "Lupa Password",
                ),
                OFormText(
                  title: "EMAIL",
                  controller: _emailController,
                  formType: FormType.email,
                ),
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
