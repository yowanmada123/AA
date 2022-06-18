import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/product/schedule_time.dart';
import 'package:boilerplate_flutter/page/payment/payment_option.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/popup/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widget/base_scaffold.dart';
import '../../widget/button_bar.dart';

class BookingDate extends StatefulWidget {
  BookingDate({Key? key}) : super(key: key);

  @override
  State<BookingDate> createState() => _BookingDateState();
}

class _BookingDateState extends State<BookingDate> {
  final listScheduleTime = <ScheduleTime>[].obs;
  final loading = true.obs;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  getData(DateTime tmpDate) async {
    String dateString = tmpDate.toyyyyMMdd();
    String options = '''
     
        mutation {
          getSchedule(
            date: "$dateString"
            scheduleID:"56599a21-fd69-4661-9856-ac512fb8a965"
          ) {
            ... on SearchScheduleResponseRows {
            nodes{
              booking
              schedule
              timePerSession
            }
              __typename
            }
            ... on Error{
              message
            }

            __typename
          }
        }

    ''';
    log(options.toString());
    Map<String, dynamic>? data = await GraphQLBase().query(options, showLoading: false);
    var list = data!['getSchedule'][0]['nodes'] as List;
    if (list.isNotEmpty) {
      List<ScheduleTime> newData = list.map((i) => ScheduleTime.fromMap(i)).toList();
      log(newData.length.toString());
      listScheduleTime.value = newData;
      log(newData.toString());
    } else {
      listScheduleTime.value = [];
    }

    log(listScheduleTime.length.toString());
    loading.value = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: 'Avaiable Schedule',
      body: ListView(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            headerVisible: true,
            headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              getData(selectedDay);
            },
          ),
          const Divider(),
          Obx(
            () => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listScheduleTime.length,
                itemBuilder: (BuildContext context, int index) {
                  return BookingTimeButton(
                    title: listScheduleTime[index].schedule,
                    isBooked: listScheduleTime[index].booking,
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar: OButtonBar(
          title: "BOOK NOW",
          onPressed: () {
            // Get.to(BookingDate());
            bottomSheetWidget(heightFactor: 0.9, context: context, child: PaymentOption());
          }),
    );
  }
}

class BookingTimeButton extends StatelessWidget {
  final String title;
  final bool isBooked;
  const BookingTimeButton({
    Key? key,
    required this.title,
    required this.isBooked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (isBooked) ? Colors.grey[100] : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: (isBooked) ? Colors.grey : Colors.white),
        ),
      ),
    );
  }
}
