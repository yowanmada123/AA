import 'dart:developer';

import 'package:boilerplate_flutter/graphql_base.dart';
import 'package:boilerplate_flutter/model/product/product.dart';
import 'package:boilerplate_flutter/model/product/schedule_time.dart';
import 'package:boilerplate_flutter/model/tournament/create_data_tournamert.dart';
import 'package:boilerplate_flutter/page/book_controller.dart';
import 'package:boilerplate_flutter/page/global_controller.dart';
import 'package:boilerplate_flutter/page/payment/payment_option.dart';
import 'package:boilerplate_flutter/page/tournament/tournament_controller.dart';
import 'package:boilerplate_flutter/utils/colors.dart';
import 'package:boilerplate_flutter/widget/extention/base_ext.dart';
import 'package:boilerplate_flutter/widget/popup/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widget/base/form/form_scaffold.dart';
import '../../widget/base/button/button_bar.dart';

class BookingDate extends StatefulWidget {
  final Product product;
  const BookingDate({Key? key, required this.product}) : super(key: key);

  @override
  State<BookingDate> createState() => _BookingDateState();
}

class _BookingDateState extends State<BookingDate> {
  final listScheduleTime = <ScheduleTime>[].obs;
  final cTournament = Get.put(TournamentController());
  final loading = true.obs;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final cGlobal = Get.find<GlobalController>();

  getData(DateTime tmpDate) async {
    String dateString = tmpDate.toyyyyMMdd();
    String options = '''
     
        query {
          getSchedule(
            date: "$dateString"
            productId:"${widget.product.id}"
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
    Map<String, dynamic>? data =
        await GraphQLBase().query(options, showLoading: false);
    if (data!['getSchedule'][0]['__typename'] != 'Error') {
      log(data.toString());
      var list = data['getSchedule'][0]['nodes'] as List;
      if (list.isNotEmpty) {
        List<ScheduleTime> newData =
            list.map((i) => ScheduleTime.fromMap(i)).toList();
        log(newData.length.toString());
        listScheduleTime.value = newData;
        log(newData.toString());
      } else {
        listScheduleTime.value = [];
      }

      log(listScheduleTime.length.toString());
    } else {
      listScheduleTime.value = [];
    }
    cGlobal.selectScheduleTime.value.clear();
    loading.value = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(_selectedDay);
  }

  final cBook = Get.find<BookController>();
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
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
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
                    return InkWell(
                      onTap: () {
                        cGlobal.selectScheduleTime.clear();
                        cGlobal.selectScheduleTime.add(listScheduleTime[index]);
                        cGlobal.selectScheduleDate.value =
                            _selectedDay.toyyyyMMdd();
                        cGlobal.refresh();
                        log("-------------------------------");
                        log(cGlobal.selectScheduleDate.value);
                        log("-------------------------------");
                        log(listScheduleTime[index].schedule);
                        log("-------------------------------");
                        cTournament.tournamentdata.scheduleDate =
                            _selectedDay.toyyyyMMdd();
                        cTournament.tournamentdata.scheduleTime =
                            listScheduleTime[index].schedule;
                        cBook.scheduleDate.value =
                            cGlobal.selectScheduleDate.value;
                        cBook.scheduleTime.value =
                            listScheduleTime[index].schedule;
                      },
                      child: (listScheduleTime[index].booking)
                          ? BookingTimeButtonBooked(
                              title: listScheduleTime[index].schedule,
                            )
                          : BookingTimeButton(
                              data: listScheduleTime[index],
                            ),
                    );
                  }),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => OButtonBar(
              title: "BOOK NOW",
              isEnable: (cGlobal.selectScheduleTime.isNotEmpty),
              onPressed: () {
                // log(cTournament.tournamentdata.name.toString());
                // log(cTournament.tournamentdata.drawSize.toString());
                // log(cTournament.tournamentdata.tournamentFormat.toString());
                // log(cTournament.tournamentdata.matchFormat.toString());
                // log(cTournament.tournamentdata.product.toString());
                // log(cTournament.tournamentdata.scheduleDate.toString());
                // log(cTournament.tournamentdata.scheduleTime.toString());
                log(cBook.selectTrainner.first.toString());
                log(cBook.selectPlace.first.toString());
                log(cBook.selectLong.value.toString());
                log(cBook.selectLat.value.toString());
                log(cBook.selectProduct.first.toString());
                log(cBook.scheduleDate.value.toString());
                log(cBook.scheduleTime.value.toString());
                bottomSheetWidget(
                    heightFactor: 0.9,
                    context: context,
                    child: const PaymentOption());
              }),
        ));
  }
}

class BookingTimeButton extends StatefulWidget {
  final ScheduleTime data;
  const BookingTimeButton({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<BookingTimeButton> createState() => _BookingTimeButtonState();
}

class _BookingTimeButtonState extends State<BookingTimeButton> {
  @override
  Widget build(BuildContext context) {
    final cGlobal = Get.find<GlobalController>();
    bool selectTime = false;

    return Obx(() => (cGlobal.selectScheduleTime.isNotEmpty)
        ? Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (cGlobal.selectScheduleTime.value.first == widget.data)
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.data.schedule,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        : Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.data.schedule,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ));
  }
}

class BookingTimeButtonBooked extends StatelessWidget {
  final String title;

  const BookingTimeButtonBooked({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(redBooked),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Booked",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
    );
  }
}
