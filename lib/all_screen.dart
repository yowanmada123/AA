import 'dart:developer';

import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/home/onboarding.dart';
import 'package:boilerplate_flutter/page/login/change_pass.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/alertx.dart';
import 'package:boilerplate_flutter/widget/base/button/button.dart';
import 'package:boilerplate_flutter/widget/base/button/button_bar.dart';
import 'package:boilerplate_flutter/widget/base/button/button_circle.dart';
import 'package:boilerplate_flutter/widget/base/button/button_circle_outline.dart';
import 'package:boilerplate_flutter/widget/base/button/button_small.dart';
import 'package:boilerplate_flutter/widget/base/button/button_small_outline.dart';
import 'package:boilerplate_flutter/widget/base/button/button_oval.dart';
import 'package:boilerplate_flutter/widget/base/button/button_square.dart';
import 'package:boilerplate_flutter/widget/base/button/button_square_outline.dart';
import 'package:boilerplate_flutter/widget/base/form/form_checkbox.dart';
import 'package:boilerplate_flutter/widget/base/form/form_checkbox_filter.dart';
import 'package:boilerplate_flutter/widget/base/form/form_date_picker.dart';
import 'package:boilerplate_flutter/widget/base/form/form_date_picker_ios.dart';
import 'package:boilerplate_flutter/widget/base/form/form_dropdown.dart';
import 'package:boilerplate_flutter/widget/base/form/form_radio_filter.dart';
import 'package:boilerplate_flutter/widget/base/form/form_search_widget.dart';
import 'package:boilerplate_flutter/widget/base/form/form_title.dart';
import 'package:boilerplate_flutter/widget/base/label/label_capsul.dart';
import 'package:boilerplate_flutter/widget/base/label/label_capsul_outline.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/base/form/form.dart';
import 'package:boilerplate_flutter/widget/base/form/form_radio.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  DateTime selectedDate = DateTime.now();
  bool accept = false;
  String radioSelected = '';
  String groupValue = '';

  List<String> itemDropdown = ["Satu", "Dua", "Tiga"];
  String dropdownValue = "Satu";

  final urlImages = ['https://wallpaperaccess.com/full/2802364.jpg', 'https://www.diykamera.com/wp-content/uploads/2017/07/cara-memotret-pemandangan.jpg', 'https://dagodreampark.co.id/media/k2/items/cache/be4e4fd1bcb87d92f342f6e3e3e1d9e2_XL.jpg'];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Template",
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      )),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Get.to(const OnboardingPage());
              },
              child: const Text("Masuk ke Onboarding", style: TextStyle(color: Colors.blueAccent)).titleText(),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.to(const ChangePasswordPage());
              },
              child: const Text("Ganti Password", style: TextStyle(color: Colors.blueAccent)).titleText(),
            ),
            const Divider(),
            Text("Form :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            const OFormText(
              title: "Nama",
              // hintText: " Form",
            ),
            const OFormText(title: "Alamat", maxLines: 4, formType: FormType.multiLine
                // hintText: " Form",
                ),
            OdatePickerAndroid(
              title: "Tanggal Lahir Android",
              date: selectedDate,
              onChanged: (val) => log(val.toString()),
            ),
            OdatePickeriOS(
              title: "Tanggal Lahir iOS",
              date: selectedDate,
              onChanged: (val) => log(val.toString()),
            ),
            const Divider(),
            Text("Color :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            Row(
              children: [
                Container(width: 30, height: 30, color: Theme.of(context).colorScheme.primary),
                Container(width: 30, height: 30, color: Theme.of(context).colorScheme.onPrimary),
                Container(width: 30, height: 30, color: Theme.of(context).colorScheme.primaryContainer),
                Container(width: 30, height: 30, color: Theme.of(context).colorScheme.onPrimaryContainer),
                Container(width: 30, height: 30, color: Theme.of(context).colorScheme.secondary),
              ],
            ),
            const Divider(),
            Text("Text :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            const Text(
              "Description Title - Nunito Bold 16",
            ).titleText(),
            const Text(
              "Page Title - Nunito Bold 14",
            ).pageTitleText(),
            const Text(
              "Field TITLE - Nunito Bold 12",
            ).fieldTitleText(),
            const Text(
              "Field Text - Nunito Regular 14",
            ).descriptionText(),
            const Text(
              "Redirect Text - Nunito Bold 12",
            ).linkText(),
            const Text(
              "Information Text - Nunito Regular 12",
            ).informationText(),
            const OTitleHeader(
              title: "Lupa Password",
            ),
            Divider(),
            Text("Button :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            const SizedBox(
              height: 10,
            ),
            OButtonBar(
              title: "ButtonBar",
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallButton(
                  title: "Small",
                  onPressed: () {},
                ),
                SmallButton(
                  title: "Small",
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                OButtonSmallOutline(
                  title: "outline",
                  icon: "assets/ic/ic_filter.svg",
                  onTap: () {},
                  outlineColor: OColorBrown,
                  titleColor: OColorBrown,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const OButtonSquare(
                  title: "Small",
                  icon: "assets/ic/ic_filter.svg",
                ),
                OButtonSquareOutline(
                  icon: "assets/ic/ic_filter.svg",
                  iconColor: Theme.of(context).colorScheme.outline,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            OButton(
              title: "OButton",
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            OButtonOVal(
              title: "OButtonOVal",
              onPressed: () {},
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OCircleButton(
                  icon: "assets/ic/ic_filter.svg",
                  onTap: () {},
                ),
                OCircleButtonOutline(
                  icon: "assets/ic/ic_filter.svg",
                  onTap: () {},
                  iconColor: Colors.yellow,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Text("Alert :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            const SizedBox(
              height: 10,
            ),
            OButtonOVal(
              title: "Confirm",
              onPressed: () {
                Alertx().confirmDialog(title: "Confirm", desc: "Are You Sure ?");
              },
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 10,
            ),
            OButtonOVal(
              title: "Error",
              onPressed: () {
                Alertx().error("Error");
              },
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 10,
            ),
            OButtonOVal(
              title: "Confirm",
              onPressed: () {
                Alertx().success("success");
              },
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Text("Label :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OLabelCapsul(
                  title: "Label 1",
                ),
                OLabelOutlineCapsul(
                  title: "Label 2",
                  color: Theme.of(context).colorScheme.onPrimary,
                  textColor: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Text("Search Widget :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            const SizedBox(
              height: 10,
            ),
            OSearchWidget(
              text: "",
              hintText: 'Example Search',
              onChanged: (String a) {},
            ),
            const Divider(),
            Text("CheckBox :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            OSquareCheckBox(
              text: "Saya telah membaca, memahami dan menyetujui syarat dan ketentuan.",
              accept: accept,
              fungsi: (val) {
                setState(() {
                  accept = !accept;
                  print(accept);
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            OCheckBox(
                text: "Fixed 1",
                accept: accept,
                fungsi: (val) {
                  setState(() {
                    accept = !accept;
                    print(accept);
                  });
                }),
            Divider(),
            Text("Radio :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            ORadio<String>(
              label: 'This is the first label text',
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              value: '1',
              groupValue: radioSelected,
              onChanged: (val) {
                setState(() {
                  radioSelected = val;
                });
                log(val);
              },
            ),
            ORadio<String>(
              label: 'This is the second label text',
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              value: '2',
              groupValue: radioSelected,
              onChanged: (val) {
                setState(() {
                  radioSelected = val;
                });
                log(val);
              },
            ),
            ORadio<String>(
              label: 'This is the third label text',
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              value: '3',
              groupValue: radioSelected,
              onChanged: (val) {
                setState(() {
                  radioSelected = val;
                });
                log(val);
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 37.0),
              child: Column(
                children: [
                  OMyRadioOption<String>(
                    value: 'A',
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    label: 'A',
                    text: 'POPULARITY',
                  ),
                  OMyRadioOption<String>(
                    value: 'B',
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    label: 'B',
                    text: 'CLOSEST DISTANCE',
                  ),
                  OMyRadioOption<String>(
                    value: 'C',
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    label: 'C',
                    text: 'PRICE: HIGH TO LOW',
                  ),
                  OMyRadioOption<String>(
                    value: 'D',
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                    label: 'D',
                    text: 'PRICE: LOW TO HIGH',
                  ),
                ],
              ),
            ),
            Divider(),
            ODropdown(
              title: "Dropdown",
              itemDropdown: itemDropdown,
              dropdownValue: dropdownValue,
              onChanged: (val) {
                setState(() {
                  dropdownValue = val;
                });
                log(val);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Text("Image Slider :", style: TextStyle(color: Theme.of(context).colorScheme.primary)).titleText(),
            const SizedBox(
              height: 10,
            ),
            OImageSlider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GlobalController.to.switchTheme(),
        child: Obx(() => Icon(GlobalController.to.isDark ? Icons.dark_mode : Icons.light_mode)),
      ),
    );
  }

  Widget OImageSlider() {
    return Column(
            children: [
              CarouselSlider.builder(
                options: CarouselOptions(initialPage: 0, viewportFraction: 1, height: 200, autoPlay: true, autoPlayAnimationDuration: const Duration(seconds: 2), reverse: true, enableInfiniteScroll: false, onPageChanged: (index, reason) => setState(() => activeIndex = index)),
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = urlImages[index];

                  return buildImage(urlImage, index);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              buildIndicator(),
            ],
          );
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex, 
    count: urlImages.length,
    effect: const JumpingDotEffect(
      dotWidth: 10,
      dotHeight: 10,
    ),
    );
}
