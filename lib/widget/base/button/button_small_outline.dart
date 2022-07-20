import 'package:boilerplate_flutter/page/booking/booking_controller.dart';
import 'package:boilerplate_flutter/page/maps/maps_open_street.dart';
import 'package:boilerplate_flutter/page/region/region_list.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form/form_radio_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../form/form_checkbox_filter.dart';

class OButtonSmallOutline extends StatefulWidget {
  final String title;
  final String icon;
  final Color? titleColor;
  final Function()? onTap;
  OButtonSmallOutline({
    Key? key,
    required this.title,
    required this.icon,
    this.titleColor,
    this.onTap,
  }) : super(key: key);

  @override
  State<OButtonSmallOutline> createState() => _OButtonSmallOutlineState();
}

class _OButtonSmallOutlineState extends State<OButtonSmallOutline> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: 104,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 2,
                color: widget.titleColor ?? Theme.of(context).colorScheme.onPrimary,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SvgPicture.asset(widget.icon),
                  ),
                  Expanded(
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.titleColor ?? Theme.of(context).colorScheme.onPrimary,
                      ),
                    ).fieldTitleText(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChoosePlaceButton extends StatefulWidget {
  @override
  State<ChoosePlaceButton> createState() => _ChoosePlaceButtonState();
}

class _ChoosePlaceButtonState extends State<ChoosePlaceButton> {
  // late String placeValue = "Jakarta";
  final cBooking = Get.find<BookingController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateAndDisplaySelection(context);
      },
      child: Container(
        height: 24,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Theme.of(context).colorScheme.secondary, style: BorderStyle.solid, width: 0.80),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 7.0, top: 1),
          child: Obx(() => Text(
                cBooking.selectRegion.value,
              )),
        ),
      ),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegionListPage()),
    );
    // setState(() {
    //   placeValue = result.name;
    // });
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$result')));
    // print(placeValue);
    // print(result);
  }
}
