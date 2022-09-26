import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../model/place/place_res.dart';
import '../../utils/colors.dart';
import '../global_controller.dart';
import 'booking_info.dart';

class PlaceItem extends StatelessWidget {
  // final CreateDataTournament? createData;
  final Place item;
  const PlaceItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            )),
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        // textAlign: TextAlign.center,
                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      ).titleText(),
                      Text(item.region.name, style: TextStyle(color: OColorBrown)).informationText(),
                      Expanded(child: Container()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: SvgPicture.asset("assets/ic/ic_location.svg"),
                          ),
                          Expanded(
                            child: Text(
                              item.address,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ).informationText(),
                          ),
                        ],
                      ),
                      // Text("Highlighted Text - Nunito Bold 14").pageTitleText(),
                    ],
                  ),
                )),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  // cGlobal.selectPlace.clear();
                  // cGlobal.selectPlace.add(item);
                  // cGlobal.selectPlace.clear();
                  // cGlobal.selectProduct.clear();
                  // cGlobal.selectPaymentMethods.clear();
                  // cGlobal.selectScheduleTime.clear();
                  Get.to(BookingInfo(
                    item: item,
                  ));
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(9),
                    bottomRight: Radius.circular(9),
                  ),
                  child: Image.network(
                    GlobalController.to.baseFile + item.images.replaceAll("\"", ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
