import 'package:boilerplate_flutter/global_service.dart';
import 'package:boilerplate_flutter/widget/date_picker.dart';
import 'package:boilerplate_flutter/widget/date_picker_ios.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
