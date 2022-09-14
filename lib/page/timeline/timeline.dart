import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/base/form/form_scaffold.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timelines/timelines.dart';

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> data = ["Create, verify, print report", "Receive result & track record", "Take photo of result"];
    return OScaffold(
      title: "Timeline",
      body: Column(
        children: [
          Timeline.tileBuilder(
            theme: TimelineThemeData(
              nodePosition: 0,
              connectorTheme: ConnectorThemeData(
                thickness: 3.0,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              indicatorTheme: const IndicatorThemeData(
                size: 15.0,
              ),
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            builder: TimelineTileBuilder.connected(
              //  contentsBuilder: (_, __) => _EmptyContents(),
              connectorBuilder: (_, index, __) => const SolidLineConnector(),
              indicatorBuilder: (_, index) => OutlinedDotIndicator(
                size: 25,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    (index + 1).toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              contentsAlign: ContentsAlign.basic,
              contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index]).pageTitleText(),
                    Text("By Admin"),
                    Text("21 May 2022 - 12:00"),
                    Text(
                      "Note",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              itemCount: data.length,
            ),
          ),
        ],
      ),
    );
  }
}
