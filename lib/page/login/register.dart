import 'dart:developer';

import 'package:boilerplate_flutter/widget/button_bar.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/form.dart';
import 'package:boilerplate_flutter/widget/title_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                 title: "Register",
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
                OFormText(
                  title: "KONFIRMASI PASSWORD",
                  controller: _passwordController,
                  formType: FormType.password,
                ),
              ],
            ),
          ),
          OButtonBar(
            title: "LANJUT",
            onPressed: () {
              if (_key.currentState!.validate()) {
                // submit();
                log("register");
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
