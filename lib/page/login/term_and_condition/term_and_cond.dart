import 'package:boilerplate_flutter/page/login/register_controller.dart';
import 'package:boilerplate_flutter/widget/button_bar.dart';
import 'package:boilerplate_flutter/widget/checkbox.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/title_form.dart';
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
  String dataTnC = "";
  String dataVersion = "";
  String dataTime = "";
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        initState: (c) {},
        builder: (c) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Version $dataVersion").titleText(),
                    Text("Updated ").informationText(),
                  ],
                ),
              ),
              TitleHeader(
                title: "Syarat Dan Ketentuan",
              ),
              Divider(
                thickness: 1,
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                            "Terms & Agreements Text - Nunito Regular 14 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Consectetur ac amet dui tortor ante aenean. Gravida orci ultrices sed ut. Donec id sodales porta nec cursus purus facilisis natoque. Dapibus venenatis sit quis condimentum ante est tincidunt non. Sollicitudin sed pharetra dictum tincidunt faucibus accumsan, cursus lectus convallis. Eleifend lectus sit eget hendrerit aliquet. Viverra elementum aliquam tellus est. Mattis at ac mi in. Et sit vel, interdum tristique cras duis senectus eget duis. Nulla tincidunt mattis a pretium eget facilisi. Elit, dolor in maecenas ornare scelerisque tristique ultrices. Sed neque, velit at nunc consectetur ullamcorper. Mauris imperdiet cras ante elementum aliquet bibendum enim feugiat aliquam. Elit porttitor pretium egestas nulla elementum semper eget. ")
                        .descriptionText()), // Html(data: dataTnC)),
              ),
              OCheckBox(
                  text:
                      "Saya telah membaca, memahami dan menyetujui syarat dan ketentuan.",
                  accept: accept,
                  fungsi: (val) {
                    setState(() {
                      accept = !accept;
                      print(accept);
                    });
                  }),
              OButtonBar(
                title: "LANJUT",
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
            ],
          );
        });
  }
}
