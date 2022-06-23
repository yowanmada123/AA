// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'package:boilerplate_flutter/page/region/region_list.dart';

class ChoosePlaceButton extends StatefulWidget {
  @override
  State<ChoosePlaceButton> createState() => _ChoosePlaceButtonState();
}

class _ChoosePlaceButtonState extends State<ChoosePlaceButton> {
  late String placeValue = "Samarinda";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateAndDisplaySelection(context);
      },
      child: Container(
          height: 24,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Theme.of(context).colorScheme.secondary, style: BorderStyle.solid, width: 0.80),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 7.0, top: 1),
            child: Text(placeValue,),
          ),
          ),
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegionListPage()),
    );
    setState(() {
      placeValue = result;
    });
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$result')));
    // print(placeValue);
  }
}
