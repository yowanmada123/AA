import 'package:boilerplate_flutter/page/activity/activity_page.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/home/home_page.dart';
import 'package:boilerplate_flutter/page/order/order_list_page.dart';
import 'package:boilerplate_flutter/page/profil/profile_page.dart';
import 'package:boilerplate_flutter/page/region/region_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class HomeNavbarButton extends StatelessWidget {
  final gstate = Get.put(GlobalController());
  HomeNavbarButton({
    Key? key,
  }) : super(key: key);

  final List<Widget> _children = [
    const HomePage(),
    ActivityPage(),
    const ProfilePage(),
  ];

  void onTabTapped(int index) {
    gstate.tabHomeIndex.value = index;
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
            content: const Text('Yakin ingin keluar aplikasi ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Tidak'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Ya'),
              ),
            ],
          ),
        )
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Obx(() => _children[gstate.tabHomeIndex.toInt()]), //
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: OprimaryColor,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped, // new
            currentIndex: gstate.tabHomeIndex.toInt(), // new
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home, color: Colors.grey,),
                // SvgPicture.asset("assets/ic/ic_home_inactive.svg"),
                label: 'Home',
                activeIcon: Icon(Icons.home, color: OprimaryColor)
                // SvgPicture.asset("assets/ic/ic_home_active.svg"),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.menu, color: Colors.grey,),
                // SvgPicture.asset("assets/ic/ic_home_inactive.svg"),
                label: 'Activity',

                activeIcon: Icon(Icons.menu, color: OprimaryColor),
                // SvgPicture.asset("assets/ic/ic_home_active.svg"),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline_rounded, color: Colors.grey,),
                // SvgPicture.asset("assets/ic/ic_home_inactive.svg"),
                label: 'Profile',
                activeIcon: Icon(Icons.person_outline_rounded, color: OprimaryColor)
                // SvgPicture.asset("assets/ic/ic_home_active.svg"),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
