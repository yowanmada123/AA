import 'package:boilerplate_flutter/page/payment/payment_detail.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/title_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class PaymentOption extends StatelessWidget {
  const PaymentOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleHeader(
          title: "Page Title - Nunito Bold 14",
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Text("FIELD TITLE - NUNITO BOLD 12").fieldTitleText(),
              const SizedBox(
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
    return InkWell(
      onTap: () {
        Get.offAll(PaymentDetailPage());
      },
      child: Column(
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
      ),
    );
  }
}
