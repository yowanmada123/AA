import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTitleHeader extends StatelessWidget {
  final String title;
  const OTitleHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(title).pageTitleText(),
          )),
        ],
      ),
    );
  }
}
