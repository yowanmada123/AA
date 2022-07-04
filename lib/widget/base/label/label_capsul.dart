import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OLabelCapsul extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? textColor;
  final bool loading;
  const OLabelCapsul({
    Key? key,
    required this.title,
    this.loading = false,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
          width: 65,
          height: 28,
          child: Center(
            child: Text(title, style: TextStyle(
                fontSize: 16,
                color: textColor ?? Colors.white,
              ),
            ).fieldTitleText(),
          ),
        );
  }
}
