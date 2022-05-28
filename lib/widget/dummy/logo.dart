import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LogoDummy extends StatelessWidget {
  const LogoDummy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 200,
      child: Container(
        color: Colors.grey,
        child: Center(child: Text("LOGO")),
      ),
    );
  }
}
