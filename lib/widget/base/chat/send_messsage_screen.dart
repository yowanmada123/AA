import 'package:boilerplate_flutter/widget/base/chat/custom_shape.dart';
import 'package:flutter/material.dart';

class SentMessageScreen extends StatelessWidget {
  final String message;

  const SentMessageScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "15 Jun 2022 - 11:37",
                style: TextStyle(fontSize: 10),
              ),
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 4,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.person),
              )),
        ),
        // CustomPaint(painter: CustomShape(Colors.cyan)),
      ],
    ));

    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
