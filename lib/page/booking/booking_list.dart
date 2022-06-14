import 'package:boilerplate_flutter/main.dart';
import 'package:boilerplate_flutter/page/booking/booking_info.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/appbar.dart';
import 'package:boilerplate_flutter/widget/base_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/list_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookingListPage extends StatefulWidget {
  const BookingListPage({Key? key}) : super(key: key);

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "Page Title - Nunito Bold 14",
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: OFilterList(
                      title: "Filter",
                      icon: "assets/ic/ic_filter.svg",
                    ),
                ),
                Expanded(
                    flex: 1,
                    child: OFilterList(
                      title: "Sort By",
                      icon: "assets/ic/ic_sort.svg",
                    )),
                Expanded(
                    flex: 1,
                    child: OFilterList(
                      title: "Maps", 
                      icon: "assets/ic/ic_nav.svg",
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                item(),
                item(),
                item(),
                item(),
                item(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  item() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(9),
            )),
        child: Row(
          children: [
            Expanded(
                // flex: 1,
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Object Title - Nunito Bold 14",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ).titleText(),
                  Text("Information Text - Nunito Regular 12",
                          style: TextStyle(color: OColorBrown))
                      .informationText(),
                  Expanded(child: Container()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: SvgPicture.asset("assets/ic/ic_location.svg"),
                      ),
                      Expanded(
                        child: Text("Information Text - Nunito Regular 12")
                            .informationText(),
                      ),
                    ],
                  ),
                  // Text("Highlighted Text - Nunito Bold 14").pageTitleText(),
                ],
              ),
            )),
            GestureDetector(
              onTap: () {
                Get.to(BookingInfo());
              },
              child: Image.asset(
                "assets/sample/image_side.png",
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }
}
