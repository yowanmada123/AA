import 'package:flutter/material.dart';
import '../../widget/button_bar.dart';
import '../../widget/extention/base_ext.dart';

class BookingInfo extends StatefulWidget {
  const BookingInfo({Key? key}) : super(key: key);

  @override
  State<BookingInfo> createState() => _BookingInfoState();
}

class _BookingInfoState extends State<BookingInfo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Image.asset(
                  "assets/sample/image_side.png",
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Lapangan Tenis Senayan').titleText(),
                          Text('0,1 Km')
                        ],
                      ),
                      Text('Jakarta, Indonesia'),
                      const SizedBox(height: 20),
                      Text(
                          'Kompleks Gelora Bung Karno Unit 4 (Jalan Asia Afrika) Jakarta, DKI Jakarta 10270, Indonesia'),
                    ],
                  ),
                ),
                Column(
                  children: [
                    OpeningHour(),
                    OpeningHour(),
                    OpeningHour(),
                    OpeningHour(),
                    OpeningHour(),
                    OpeningHour(),
                    OpeningHour(),
                  ],
                ),
              ],
            ),
          ),
          OButtonBar(title: "BOOK NOW", onPressed: () {})
          // TabBar(tabs: [
          //   Tab(
          //     text: 'About',
          //   ),
          //   Tab(
          //     text: 'Opening Hour',
          //   )
          // ]),
          // Expanded(
          //   child: TabBarView(
          //     children: <Widget>[
          //       Icon(Icons.flight, size: 350),
          //       Icon(Icons.directions_transit, size: 350),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

class OpeningHour extends StatelessWidget {
  const OpeningHour({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Mon'),
          Text('08.00 - 09.00'),
        ],
      ),
    );
  }
}
