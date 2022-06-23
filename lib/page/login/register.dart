import 'dart:developer';

import 'package:boilerplate_flutter/page/login/register_controller.dart';
import 'package:boilerplate_flutter/page/login/term_and_condition/term_and_cond.dart';
import 'package:boilerplate_flutter/widget/base/alertx.dart';
import 'package:boilerplate_flutter/widget/base/button_bar.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form.dart';
import 'package:boilerplate_flutter/widget/popup/bottom_sheet.dart';
import 'package:boilerplate_flutter/widget/base/title_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: "");
  final _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: GetBuilder<RegisterController>(
          init: RegisterController(),
          initState: (_) {},
          builder: (c) {
            return ListView(
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
                        controller: _rePasswordController,
                        formType: FormType.password,
                      ),
                    ],
                  ),
                ),
                OButtonBar(
                  title: "LANJUT",
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      //   // submit();
                      c.email = _emailController.text;
                      c.password = _rePasswordController.text;
                      if (_rePasswordController.text == _passwordController.text) {
                        bottomSheetWidget(heightFactor: 0.9, context: context, child: TandCPage());
                        //   log("register");
                      } else {
                        Alertx().error("Password tidak sama");
                      }
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
