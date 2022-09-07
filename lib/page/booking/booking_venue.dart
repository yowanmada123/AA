import 'package:boilerplate_flutter/page/booking/booking_list.dart';
import 'package:boilerplate_flutter/page/booking/data/data_image.dart';
import 'package:boilerplate_flutter/widget/base/button/button_base.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../widget/base/form/form_scaffold.dart';

class BookingVenuePage extends StatefulWidget {
  const BookingVenuePage({Key? key}) : super(key: key);

  @override
  State<BookingVenuePage> createState() => _BookingVenuePageState();
}

class _BookingVenuePageState extends State<BookingVenuePage> {
  int activeIndex = 0;
  final controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "Booking",
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 242,
            width: Get.width,
            child: CarouselSlider.builder(
              carouselController: controller,
              options: CarouselOptions(initialPage: 0, viewportFraction: 1, height: 305, autoPlay: false, autoPlayAnimationDuration: const Duration(seconds: 1), reverse: false, enableInfiniteScroll: false, onPageChanged: (index, reason) => setState(() => activeIndex = index)),
              itemCount: allImage.length,
              itemBuilder: (context, index, realIndex) {
                return ImageProduct(
                  product: allImage[index],
                );
              },
            ),
          ),
          const SizedBox(
            height: 38,
          ),
          const Text("Choose your Venue Type").titleText().black(),
          const SizedBox(
            height: 38,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                Expanded(
                    child: BaseButton(
                  ontap: () {
                    Get.to(const BookingListPage());
                  },
                  outlineColor: Colors.grey,
                  color: Colors.white,
                  textColor: Colors.black,
                  iconSvg: "assets/ic/ic_indoor.png",
                  text: "Indoor",
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: BaseButton(
                  ontap: () {},
                  outlineColor: Colors.grey,
                  color: Colors.white,
                  textColor: Colors.black,
                  iconSvg: "assets/ic/ic_outdoor.png",
                  text: "Outdoor",
                ))
              ],
            ),
          )
        ],
      )),
    );
  }
}

class ImageProduct extends StatelessWidget {
  final ProductImage product;
  const ImageProduct({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        // padding: const EdgeInsets.all(16),
        height: 300,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                // AssetImage("assets/images/morefood1.jpg"),
                AssetImage(product.image),
            fit: BoxFit.cover,
          ),
          // border: Border.all(color: Colors.black87,),
          // borderRadius: BorderRadius.circular(10),
        ),
      ),
    ]);
  }
}
