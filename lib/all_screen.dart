import 'dart:developer';

import 'package:boilerplate_flutter/global_service.dart';
import 'package:boilerplate_flutter/page/home/onboarding.dart';
import 'package:boilerplate_flutter/page/login/change_pass.dart';
import 'package:boilerplate_flutter/widget/base/button.dart';
import 'package:boilerplate_flutter/widget/base/button_bar.dart';
import 'package:boilerplate_flutter/widget/base/checkbox.dart';
import 'package:boilerplate_flutter/widget/base/date_picker.dart';
import 'package:boilerplate_flutter/widget/base/date_picker_ios.dart';
import 'package:boilerplate_flutter/widget/base/dropdown.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form.dart';
import 'package:boilerplate_flutter/widget/base/radio.dart';
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
  bool accept = false;
  String radioSelected = '';

  List<String> itemDropdown = ["Satu", "Dua", "Tiga"];
  String dropdownValue = "Satu";
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
                Get.to(const OnboardingPage());
              },
              child: const Text("Masuk ke Onboarding", style: TextStyle(color: Colors.blueAccent)).titleText(),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.to(const ChangePasswordPage());
              },
              child: const Text("Ganti Password", style: TextStyle(color: Colors.blueAccent)).titleText(),
            ),
            const Divider(),
            Text("Form :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            const OFormText(
              title: "Nama",
              // hintText: " Form",
            ),
            const OFormText(title: "Alamat", maxLines: 4, formType: FormType.multiLine
                // hintText: " Form",
                ),
            OdatePickerAndroid(
              title: "Tanggal Lahir Android",
              date: selectedDate,
              onChanged: (val) => log(val.toString()),
            ),
            OdatePickeriOS(
              title: "Tanggal Lahir iOS",
              date: selectedDate,
              onChanged: (val) => log(val.toString()),
            ),
            const Divider(),
            Text("Color :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            Row(
              children: [
                Container(width: 30, height: 30, color: Theme.of(context).colorScheme.primary),
                Container(width: 30, height: 30, color: Theme.of(context).colorScheme.onPrimary),
                Container(width: 30, height: 30, color: Theme.of(context).colorScheme.primaryContainer),
                Container(width: 30, height: 30, color: Theme.of(context).colorScheme.onPrimaryContainer),
                Container(width: 30, height: 30, color: Theme.of(context).colorScheme.secondary),
              ],
            ),
            Divider(),
            Text("Text :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
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
            ).linkText(),
            Text(
              "Information Text - Nunito Regular 12",
            ).informationText(),
            Divider(),
            Text("Button :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            OButton(
              title: "Button 1 - Nunito bold 14 ",
              onPressed: () {},
            ),
            SizedBox(
              height: 10,
            ),
            OButtonBar(
              title: "Fixed 1 - Nunito bold 14 ",
              onPressed: () {},
            ),
            Divider(),
            Text("CheckBox :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            OCheckBox(
                text: "Saya telah membaca, memahami dan menyetujui syarat dan ketentuan.",
                accept: accept,
                fungsi: (val) {
                  setState(() {
                    accept = !accept;
                    print(accept);
                  });
                }),
            Divider(),
            Text("Radio :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            ORadio<String>(
              label: 'This is the first label text',
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              value: '1',
              groupValue: radioSelected,
              onChanged: (val) {
                setState(() {
                  radioSelected = val;
                });
                log(val);
              },
            ),
            ORadio<String>(
              label: 'This is the second label text',
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              value: '2',
              groupValue: radioSelected,
              onChanged: (val) {
                setState(() {
                  radioSelected = val;
                });
                log(val);
              },
            ),
            ORadio<String>(
              label: 'This is the third label text',
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              value: '3',
              groupValue: radioSelected,
              onChanged: (val) {
                setState(() {
                  radioSelected = val;
                });
                log(val);
              },
            ),
            Divider(),
            ODropdown(
              title: "Dropdown",
              itemDropdown: itemDropdown,
              dropdownValue: dropdownValue,
              onChanged: (val) {
                setState(() {
                  dropdownValue = val;
                });
                log(val);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GlobalService.to.switchTheme(),
        child: Obx(() => Icon(GlobalService.to.isDark ? Icons.dark_mode : Icons.light_mode)),
      ),
    );
  }
}
