import 'package:boilerplate_flutter/widget/date_picker.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
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
            OdatePickerAndroid(title: "Tanggal Lahir",),
          ],
        ),
      ),
    );
  }
}
