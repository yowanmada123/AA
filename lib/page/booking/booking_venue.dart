import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
              height: 20,
              width: 20,
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
          ],
        )
      ),
    );
  }
}
