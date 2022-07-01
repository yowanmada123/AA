import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OCircleButton extends StatelessWidget {
  final String? title;
  final String? icon;
  final Function() onPressed;
  final Color? color;
  final Color? iconColor;
  final bool loading;
  const OCircleButton({
    Key? key,
    this.title,
    required this.onPressed,
    required this.icon,
    this.loading = false,
    this.color,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
            width: 48,
            height: 48,
            child: ClipOval(
              child: Material(
                color: (color == null) ? Theme.of(context).colorScheme.primary : color,
                child: InkWell(
                  splashColor: Colors.red, // Splash color
                  onTap: () {},
                  child: 
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: (icon == null)
                        ? Container()
                        : (icon == null)
                            ? Container()
                            : Icon(
                                Icons.menu,
                                color: (iconColor == null) ? Theme.of(context).colorScheme.onPrimary : iconColor,
                              ),
                  ),
                  // Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 5),
                  //     child:
                  //     SvgPicture.asset(icon!),
                  // ),
                ),
              ),
            ),
          );
  }
}
