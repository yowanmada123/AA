import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class xForm extends StatelessWidget {
  final String? title;
  final String? hintText;
  const xForm({Key? key, this.title, this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
            labelText: title,
            hintText: hintText,
            labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)));
  }
}
