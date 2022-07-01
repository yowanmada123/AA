import 'package:boilerplate_flutter/page/login/register_controller.dart';
import 'package:boilerplate_flutter/widget/base/button/button_bar.dart';
import 'package:boilerplate_flutter/widget/base/form/form_checkbox.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form/form_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class TandCPage extends StatefulWidget {
  const TandCPage({Key? key}) : super(key: key);

  @override
  State<TandCPage> createState() => _TandCPageState();
}

class _TandCPageState extends State<TandCPage> {
  bool accept = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        initState: (c) {},
        builder: (c) {
          return Column(
            children: [
              OTitleHeader(
                title: "Syarat Dan Ketentuan",
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Version ${c.tncVersion}").titleText(),
                    Text("Updated ${c.tncUpdatedAt}").informationText(),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(c.tncContent)
                        .descriptionText()), // Html(data: dataTnC)),
              ),
              OSquareCheckBox(
                  text:
                      "Saya telah membaca, memahami dan menyetujui syarat dan ketentuan.",
                  accept: accept,
                  fungsi: (val) {
                    setState(() {
                      accept = !accept;
                      print(accept);
                    });
                  }),
              Expanded(
                child: OButtonBar(
                  title: "LANJUT",
                  isEnable: accept,
                  onPressed: () async {
                    // if (res != null) {
                    //   Get.to(EmailSentPage(
                    //     email: widget.email,
                    //     password: widget.password,
                    //   ));
                    // }
                    if (accept) {
                      await c.signUpEmail();
                    }
                  },
                  // color: Color((accept) ? primaryDark : greyLight),
                  textColor: Colors.white,
                ),
              ),
            ],
          );
        });
  }
}
