import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/title_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PaymentOption extends StatelessWidget {
  const PaymentOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleHeader(
          title: "Page Title - Nunito Bold 14",
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Text("FIELD TITLE - NUNITO BOLD 12").fieldTitleText(),
              SizedBox(
                height: 12,
              ),
              ItemPayment(),
              ItemPayment(),
              ItemPayment(),
              ItemPayment(),
            ],
          ),
        ))
      ],
    );
  }
}

class ItemPayment extends StatelessWidget {
  const ItemPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/sample/bca.png",
                // width: 40,
                height: 25,
              ),
            ),
            Expanded(
                child: Text("Field Text - Nunito Regular 14").regularText()),
            Icon(Icons.arrow_right)
          ],
        ),
        Divider()
      ],
    );
  }
}
