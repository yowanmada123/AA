import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OCheckBox extends StatelessWidget {
  final Function(bool?)? fungsi;
  final bool accept;
  final String text;
  Widget? child;
  OCheckBox(
      {Key? key,
      required this.fungsi,
      required this.accept,
      required this.text,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        checkColor: Theme.of(context).colorScheme.onPrimary,
        activeColor: Theme.of(context).colorScheme.primary,
        title: (child != null)
            ? child
            : Text(
                text,
              ).regularText(),
        value: accept,
        onChanged: fungsi);
  }
}
