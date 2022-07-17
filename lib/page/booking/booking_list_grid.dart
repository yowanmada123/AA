import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/base/form/form_search_widget.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BookingListGridPage extends StatefulWidget {
  const BookingListGridPage({Key? key}) : super(key: key);

  @override
  State<BookingListGridPage> createState() => _BookingListGridPageState();
}

class _BookingListGridPageState extends State<BookingListGridPage> {
  bool accept = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: "List Order",
      backgroundColor: Color(redBooked),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset("assets/ic/ic_location.svg"),
                ),
                Text("Ciputat, Tangerang Selatan, 15411, Jawa Barat"),
                TextButton(onPressed: () {}, child: Text("Ganti"))
              ],
            ),
          ),
          OSearchWidget(
            text: "",
            hintText: 'Cari Jenis Pelayanan',
            onChanged: (String a) {},
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                ItemPlace(),
                ItemPlace(),
                ItemPlace(),
                ItemPlace(),
                ItemPlace(),
                ItemPlace(),
                ItemPlace(),
                ItemPlace(),
                ItemPlace(),
                ItemPlace(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemPlace extends StatelessWidget {
  const ItemPlace({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cGlobal = Get.find<GlobalController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Icon(
                          Icons.image,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        "IHC",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      ).regularBigText(),
                      Text("6 test dijalankan", style: TextStyle(color: OColorBrown)).informationText(),
                      Text(
                        "Rp559.000",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(black)),
                      ).titleText(),

                      Expanded(child: Container()),
                      Text(
                        "Pilih",
                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      ).informationText(),
                      // Text("Highlighted Text - Nunito Bold 14").pageTitleText(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
