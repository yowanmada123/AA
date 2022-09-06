import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseButton extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Color? color;
  final Color? textColor;
  final Function() ontap;
  final String? image;
  const BaseButton({Key? key, this.icon, this.text, this.color, required this.ontap, this.textColor, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 48,
        width: Get.width * 0.95,
        decoration: BoxDecoration(color: (color == null) ? const Color(0xff2D79F6) : color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: 
          (icon == null && image == null)
              ? Text(
                  text!,
                  style: TextStyle(color: (textColor == null) ? Colors.white : textColor),
                ).pageTitleText()
              :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (image == null) ?
                  Icon(icon) : 
                  Image.asset(image!, width: 24, height: 24,),
                  const SizedBox(
                    width: 8,
                  ),
                  (textColor == null)
                      ? Text(text!).pageTitleText().white()
                      : Text(
                          text!,
                          style: TextStyle(color: textColor),
                        )
                  // .pageTitleText()
                ],
              ),
        ),
      ),
    );
  }
}
