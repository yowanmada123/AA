import 'package:boilerplate_flutter/global_service.dart';
import 'package:boilerplate_flutter/page/home/onboarding.dart';
import 'package:boilerplate_flutter/page/login/change_pass.dart';
import 'package:boilerplate_flutter/widget/button.dart';
import 'package:boilerplate_flutter/widget/button_bar.dart';
import 'package:boilerplate_flutter/widget/checkbox.dart';
import 'package:boilerplate_flutter/widget/date_picker.dart';
import 'package:boilerplate_flutter/widget/date_picker_ios.dart';
import 'package:boilerplate_flutter/widget/dropdown.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/form.dart';
import 'package:boilerplate_flutter/widget/radio.dart';
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
  bool _isRadioSelected = false;

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
                Get.to(OnboardingPage());
              },
              child: Text("Masuk ke Onboarding",
                      style: TextStyle(color: Colors.blueAccent))
                  .titleText(),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.to(ChangePasswordPage());
              },
              child: Text("Ganti Password",
                      style: TextStyle(color: Colors.blueAccent))
                  .titleText(),
            ),
            Divider(),
            Text("Form :",
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
            Divider(),
            Text("Color :",
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
            Divider(),
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
            ).linkText(),
            Text(
              "Information Text - Nunito Regular 12",
            ).informationText(),
            Divider(),
            Text("Button :",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary))
                .titleText(),
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
            Text("CheckBox :",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary))
                .titleText(),
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
            Divider(),
            Text("Radio :",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary))
                .titleText(),
            ORadio(
              label: 'This is the first label text',
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              value: true,
              groupValue: _isRadioSelected,
              onChanged: (bool newValue) {
                setState(() {
                  _isRadioSelected = newValue;
                });
              },
            ),
            ORadio(
              label: 'This is the second label text',
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              value: false,
              groupValue: _isRadioSelected,
              onChanged: (bool newValue) {
                setState(() {
                  _isRadioSelected = newValue;
                });
              },
            ),
            Divider(),
            Text("Dropdown :",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary))
                .titleText(),
            ODropdown(
              itemDropdown: itemDropdown,
              dropdownValue: dropdownValue,
              onChanged: (val) {
                setState(() {
                  dropdownValue = val;
                });
              },
            )
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
