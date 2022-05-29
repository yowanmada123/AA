import 'package:boilerplate_flutter/widget/button.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController(text: "");
  final _passwordController = TextEditingController(text: "");
  final _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ganti Password").pageTitleText(),
      ),
      body: Form(
        key: _key,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                children: [
                  OFormText(
                    title: "PASSWORD LAMA",
                    controller: _oldPasswordController,
                    formType: FormType.password,
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
            OButton(
              title: "LANJUT",
              onPressed: () {
                if (_key.currentState!.validate()) {
                  //   // submit();
                  //   c.email = _emailController.text;
                  //   c.password = _rePasswordController.text;
                  //   c.signUpEmail();
                  //   log("register");
                }
              },
              // color: Color(primaryDark),
              // textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
