import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widget/base_scaffold.dart';
import '../../widget/button_bar.dart';

class BookingDate extends StatefulWidget {
  BookingDate({Key? key}) : super(key: key);

  @override
  State<BookingDate> createState() => _BookingDateState();
}

class _BookingDateState extends State<BookingDate> {
  @override
  Widget build(BuildContext context) {
    return OScaffold(
      title: 'Avaiable Schedule',
      body: ListView(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
          ),
          Divider(),
          Column(
            children: [
              BookingTimeButton(
                title: 'Booked',
                isBooked: true,
              ),
              BookingTimeButton(
                title: '10.00 - 11.00',
                isBooked: false,
              ),
              BookingTimeButton(
                title: '10.00 - 11.00',
                isBooked: false,
              ),
              BookingTimeButton(
                title: '10.00 - 11.00',
                isBooked: false,
              ),
              BookingTimeButton(
                title: '10.00 - 11.00',
                isBooked: false,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: OButtonBar(
          title: "BOOK NOW",
          onPressed: () {
            // Get.to(BookingDate());
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
        color: (isBooked)
            ? Colors.grey[100]
            : Theme.of(context).colorScheme.primary,
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
