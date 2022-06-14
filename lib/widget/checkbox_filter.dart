import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class FCheckBox extends StatelessWidget {
  final Function(bool?)? fungsi;
  final bool accept;
  final String text;
  Widget? child;
  FCheckBox(
      {Key? key,
      required this.fungsi,
      required this.accept,
      required this.text,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            checkColor: Theme.of(context).colorScheme.onPrimary,
            activeColor: Theme.of(context).colorScheme.primary,
            value: accept,
            onChanged: fungsi),
        Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ).titleText(),
      ],
    );
  }
}
