import 'package:boilerplate_flutter/page/login/login.dart';

import 'package:boilerplate_flutter/widget/extention/ext_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import '../../widget/base/base_button.dart';
import 'small_button.dart';

// import '../../constant.dart';

class Alertx {
  final gstate = Get.find<GlobalController>();

  success(String? message, {String title = 'Success', String code = ''}) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: 100,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Icon(
                Icons.check,
                size: 50,
                color: Colors.green,
              ),
              const SizedBox(height: 10),
              Text(
                title,
              ),
              const SizedBox(height: 10),
              Text(
                message ?? '',
              ),
              const SizedBox(height: 20),
              BaseButton(
                  title: 'OK',
                  color: Colors.green,
                  onPressed: () {
                    Get.back();
                  })
            ],
          ),
        ),
      ),
    ));
  }

  Future<dynamic> confirmDialog({String title = '', desc = ''}) async {
    return Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Text(title).title(),
              const SizedBox(height: 10),
              Text(desc),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: GestureDetector(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      child: Text('Tidak'),
                    ),
                    onTap: () {
                      Get.back(result: false);
                    },
                  )),
                  Flexible(
                    child: SmallButton(
                        title: 'Ya',
                        // color: Colors.green,
                        onPressed: () {
                          Get.back(result: true);
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
    // return showDialog(
    //   context: Get.context!,
    //   builder: (context) => AlertDialog(
    //     // title: new Text('Are you sure?'),
    //     content: RichText(
    //       text: TextSpan(
    //         text: label,
    //         style: const TextStyle(color: Colors.black, fontSize: 16),
    //         children: <TextSpan>[
    //           TextSpan(
    //               text: itemName, style: const TextStyle(color: Colors.red)),
    //           const TextSpan(text: ' ?', style: TextStyle(color: Colors.black)),
    //         ],
    //       ),
    //     ),
    //     actions: <Widget>[
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(false),
    //         child: const Text(
    //           'Tidak',
    //           style: TextStyle(color: Colors.grey),
    //         ),
    //       ),
    //       TextButton(
    //         onPressed: () => Navigator.of(context).pop(true),
    //         child: const Text(
    //           'Ya',
    //           style: const TextStyle(color: Colors.red),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  loading() {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: 100,
        width: 50,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    ));
  }

  error(String? message, {String title = 'Oops...', String code = ''}) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: 300,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Icon(
                Icons.error,
                size: 80,
                color: Colors.orange,
              ),
              const SizedBox(height: 10),
              Text(title).title(),
              const SizedBox(height: 10),
              Text(message ?? ''),
              const SizedBox(height: 20),
              BaseButton(
                  title: 'OK',
                  onPressed: () {
                    if (code == 'UNAUTHENTICATED') {
                      gstate.token = '';
                      Get.offAll(const LoginPage());
                    } else {
                      Get.back();
                    }
                  })
            ],
          ),
        ),
      ),
    ));
  }
}