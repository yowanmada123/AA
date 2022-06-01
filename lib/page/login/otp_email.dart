import 'package:boilerplate_flutter/page/login/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpEmailPage extends StatefulWidget {
  final String email;

  const OtpEmailPage({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpEmailPage> createState() => _OtpEmailPageState();
}

class _OtpEmailPageState extends State<OtpEmailPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController otpController = TextEditingController();
  Color color = Colors.grey;
  bool error = false;
  int countError = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        initState: (_) {},
        builder: (c) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kode OTP sudah dikirim via Email ke ',
                    ),
                    Text(
                      widget.email,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        autoFocus: true,
                        obscureText: false,
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          // if (v.length < 4) {
                          //   return "";
                          // } else {
                          //   return null;
                          // }
                        },
                        pinTheme: PinTheme(
                          activeColor: color,
                          selectedColor: color,
                          inactiveColor: Colors.grey,
                          fieldHeight: 50,
                          fieldWidth: 50,
                        ),
                        textStyle: TextStyle(
                          color: (error) ? Colors.red : Colors.black,
                          fontSize: 40,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        // errorAnimationController: errorController,
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          print("Completed");
                          // cekOtp(v);
                          c.validasiEmail(v);
                        },
                        onChanged: (value) {
                          // print(value);
                          // setState(() {
                          //   phone = value;
                          // });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return false;
                        },
                        autoDismissKeyboard: false,
                      ),
                      // buildTimer(),
                      SizedBox(height: 10),
                      if (countError >= 3)
                        Text(
                          'Kode salah, percobaan $countError dari 3. Silakan kirim ulang OTP',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tidak menerima email ?',
                      style: TextStyle(),
                    ),
                    InkWell(
                      child: Text(
                        ' KIRIM ULANG OTP',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
