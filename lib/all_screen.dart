import 'dart:developer';

import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/home/onboarding.dart';
import 'package:boilerplate_flutter/page/login/change_pass.dart';
import 'package:boilerplate_flutter/widget/base/button/button.dart';
import 'package:boilerplate_flutter/widget/base/button/button_bar.dart';
import 'package:boilerplate_flutter/widget/base/button/button_circle.dart';
import 'package:boilerplate_flutter/widget/base/button/button_small.dart';
import 'package:boilerplate_flutter/widget/base/button/button_small_outline.dart';
import 'package:boilerplate_flutter/widget/base/button/button_square.dart';
import 'package:boilerplate_flutter/widget/base/form/form_checkbox.dart';
import 'package:boilerplate_flutter/widget/base/form/form_checkbox_filter.dart';
import 'package:boilerplate_flutter/widget/base/form/form_date_picker.dart';
import 'package:boilerplate_flutter/widget/base/form/form_date_picker_ios.dart';
import 'package:boilerplate_flutter/widget/base/form/form_dropdown.dart';
import 'package:boilerplate_flutter/widget/base/form/form_radio_filter.dart';
import 'package:boilerplate_flutter/widget/base/form/form_search_widget.dart';
import 'package:boilerplate_flutter/widget/base/form/form_title.dart';
import 'package:boilerplate_flutter/widget/base/label/label_capsul.dart';
import 'package:boilerplate_flutter/widget/base/label/label_capsul_outline.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form/form.dart';
import 'package:boilerplate_flutter/widget/base/form/form_radio.dart';
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
  String groupValue = '';

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
            const Divider(),
            Text("Text :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            const Text(
              "Description Title - Nunito Bold 16",
            ).titleText(),
            const Text(
              "Page Title - Nunito Bold 14",
            ).pageTitleText(),
            const Text(
              "Field TITLE - Nunito Bold 12",
            ).fieldTitleText(),
            const Text(
              "Field Text - Nunito Regular 14",
            ).descriptionText(),
            const Text(
              "Redirect Text - Nunito Bold 12",
            ).linkText(),
            const Text(
              "Information Text - Nunito Regular 12",
            ).informationText(),
            const OTitleHeader(
                  title: "Lupa Password",
                ),
            Divider(),
            Text("Button :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            OButton(
              title: "Button 1 - Nunito bold 14 ",
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            OButtonBar(
              title: "Fixed 1 - Nunito bold 14 ",
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            SmallButton(
              title: "Fixed 1 - Nunito bold 14 ",
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            OButton(
              title: "Fixed 1 - Nunito bold 14 ",
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            SquareButton(
              title: "Fixed 1 - Nunito bold 14 ",
              onPressed: () {},
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 10,
            ),
            OSmallOutlinebutton(title: "Fixed 1 - Nunito bold 14 ", icon: "assets/ic/ic_filter.svg"),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OCircleButton(
                  icon: "assets/ic/ic_filter.svg",
                  onPressed: () {},
                ),
                 OCircleButton(
                  icon: "assets/ic/ic_filter.svg",
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Text("Label :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OLabelCapsul(
                  title: "Label 1",
                ),
                OLabelOutlineCapsul(
                  title: "Label 2",
                  color: Theme.of(context).colorScheme.onPrimary,
                  textColor: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Text("Search Widget :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            const SizedBox(
              height: 10,
            ),
            OSearchWidget(
              text: "",
              hintText: 'Example Search',
              onChanged: (String a){},
            ),
            const Divider(),
            Text("CheckBox :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            OSquareCheckBox(
              text: "Saya telah membaca, memahami dan menyetujui syarat dan ketentuan.",
              accept: accept,
              fungsi: (val) {
                setState(() {
                  accept = !accept;
                  print(accept);
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            OCheckBox(
                text: "Fixed 1",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 37.0),
              child: Column(
                children: [
                  OMyRadioOption<String>(
                    value: 'A',
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    label: 'A',
                    text: 'POPULARITY',
                  ),
                  OMyRadioOption<String>(
                    value: 'B',
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    label: 'B',
                    text: 'CLOSEST DISTANCE',
                  ),
                  OMyRadioOption<String>(
                    value: 'C',
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    label: 'C',
                    text: 'PRICE: HIGH TO LOW',
                  ),
                  OMyRadioOption<String>(
                    value: 'D',
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    label: 'D',
                    text: 'PRICE: LOW TO HIGH',
                  ),
                ],
              ),
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
        onPressed: () => GlobalController.to.switchTheme(),
        child: Obx(() => Icon(GlobalController.to.isDark ? Icons.dark_mode : Icons.light_mode)),
      ),
    );
  }
}
