import 'package:boilerplate_flutter/global_service.dart';
import 'package:boilerplate_flutter/page/home/onboarding.dart';
import 'package:boilerplate_flutter/widget/date_picker.dart';
import 'package:boilerplate_flutter/widget/date_picker_ios.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Template",
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      )),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Get.to(OnboardingPage());
              },
              child: Text("Masuk ke Onboarding",
                      style: TextStyle(color: Colors.blueAccent))
                  .titleText(),
            ),
            Text("Form",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary))
                .titleText(),
            OFormText(
              title: "Nama",
              // hintText: " Form",
            ),
            OFormText(title: "Alamat", maxLines: 4, formType: FormType.multiLine
                // hintText: " Form",
                ),
            OdatePickerAndroid(
              title: "Tanggal Lahir Android",
              date: selectedDate,
            ),
            OdatePickeriOS(
              title: "Tanggal Lahir iOS",
              date: selectedDate,
            ),
            Text("Color",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary))
                .titleText(),
            Row(
              children: [
                Container(
                    width: 30,
                    height: 30,
                    color: Theme.of(context).colorScheme.primary),
                Container(
                    width: 30,
                    height: 30,
                    color: Theme.of(context).colorScheme.onPrimary),
                Container(
                    width: 30,
                    height: 30,
                    color: Theme.of(context).colorScheme.primaryContainer),
                Container(
                    width: 30,
                    height: 30,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
                Container(
                    width: 30,
                    height: 30,
                    color: Theme.of(context).colorScheme.secondary),
              ],
            ),
            Text("Text :",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary))
                .titleText(),
            Text(
              "Description Title - Nunito Bold 16",
            ).titleText(),
            Text(
              "Page Title - Nunito Bold 14",
            ).pageTitleText(),
            Text(
              "Field TITLE - Nunito Bold 12",
            ).fieldTitleText(),
            Text(
              "Field Text - Nunito Regular 14",
            ).descriptionText(),
            Text(
              "Redirect Text - Nunito Bold 12",
            ).redirectText(),
            Text(
              "Information Text - Nunito Regular 12",
            ).informationText(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GlobalService.to.switchTheme(),
        child: Obx(() =>
            Icon(GlobalService.to.isDark ? Icons.dark_mode : Icons.light_mode)),
      ),
    );
  }
}
