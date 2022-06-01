import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OButtonBar extends StatelessWidget {
  final String title;
  final Widget? icon;
  final Function() onPressed;
  final Color? color;
  final Color? textColor;
  final bool loading;
  final bool isEnable;
  const OButtonBar({
    Key? key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.isEnable = true,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: color ?? Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      // color: Theme.of(context).primaryColor,
    );

    return (loading)
        ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
            width: double.infinity,
            // constraints: BoxConstraints(
            //   maxWidth:
            // ),
            height: 60,
            child: TextButton(
              style: (isEnable)
                  ? flatButtonStyle
                  : TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      // color: Theme.of(context).primaryColor,
                    ),
              onPressed: (isEnable) ? onPressed : null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (icon == null)
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: icon,
                          ),
                        ),
                  Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor ?? Colors.white,
                      ),
                    ).titleText(),
                  ),
                ],
              ),
            ),
          );
  }
}
