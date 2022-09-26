import 'dart:developer';

import 'package:get/get.dart';

import 'package:boilerplate_flutter/model/place/place_res.dart';
import 'package:boilerplate_flutter/model/product/product.dart';
import 'package:boilerplate_flutter/model/product/schedule_time.dart';
import 'package:boilerplate_flutter/model/user/trainer.dart';
import 'package:boilerplate_flutter/widget/extention/ext_date.dart';

import '../graphql_base.dart';
import '../model/payment/payment_methods.dart';

enum BookingType { veneu, trainer, tournament }

class BookController extends GetxController {
  Future<BookController> init() async {
    return this;
  }

  var selectTrainner = <Trainers>[].obs;
  var selectPlace = <Place>[].obs;
  var selectLong = 0.0.obs;
  var selectLat = 0.0.obs;
  var selectProduct = <Product>[].obs;
  var bookingDateTime = <BookingTimeDate>[].obs;

  late PaymentMethods paymentMethods;
  late Product product;
  late BookingType bookingType;

  void toggleSchedule(BookingTimeDate bookingTimeDate) {
    if (bookingDateTime.contains(bookingTimeDate)) {
      bookingDateTime.remove(bookingTimeDate);
    } else {
      bookingDateTime.add(bookingTimeDate);
    }
    print(bookingDateTime);
  }

  submitBooking() {
    log(bookingType.toString());
    switch (bookingType) {
      case BookingType.veneu:
        bookingVenue();
        break;
      case BookingType.trainer:
        // bookingTrainer();
        log(selectProduct.first.name);
        break;
      case BookingType.tournament:
        // bookingTurnament();
        break;
      default:
    }
  }

  Future<String?> bookingVenue() async {
    String payment_method = paymentMethods.id;
    String phone_number = "";
    String? product_id = product.id;
    String scheduled_date = bookingDateTime[0].date.toyyyyMMdd();
    String scheduled_time = bookingDateTime[0].time.schedule;

    String data = '''
              mutation {
                createTransaction(
                  input: {
                    payment_method: "$payment_method"
                    phone_number: "085259737334"
                    product_id: "$product_id"
                    scheduled_date: "$scheduled_date"
                    scheduled_time: "$scheduled_time"
                  }
                ) {
                  __typename
                 ... on Error{
                    message
                  }
                  ... on  SuccessCreateTransaction{
                    transactionId
                  }
                  ... on InvalidInputError{
                    message
                  }
                }
              }

''';
    log(data);
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(data);
      if (res != null) {
        return res["createTransaction"][0]["transactionId"];
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }

  Future<String?> bookinTrainer() async {
    String payment_method = paymentMethods.id;
    String phone_number = "";
    String? product_id = product.id;
    String scheduled_date = bookingDateTime[0].date.toyyyyMMdd();
    String scheduled_time = bookingDateTime[0].time.schedule;

    String data = '''
              mutation {
                createTransaction(
                  input: {
                    payment_method: "$payment_method"
                    phone_number: "085259737334"
                    product_id: "$product_id"
                    scheduled_date: "$scheduled_date"
                    scheduled_time: "$scheduled_time"
                  }
                ) {
                  __typename
                 ... on Error{
                    message
                  }
                  ... on  SuccessCreateTransaction{
                    transactionId
                  }
                  ... on InvalidInputError{
                    message
                  }
                }
              }

''';
    log(data);
    try {
      Map<String, dynamic>? res = await GraphQLBase().mutate(data);
      if (res != null) {
        return res["createTransaction"][0]["transactionId"];
      }
    } on Error catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }
}

class BookingTimeDate {
  DateTime date;
  ScheduleTime time;
  BookingTimeDate({
    required this.date,
    required this.time,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingTimeDate && other.date == date && other.time == time;
  }

  @override
  String toString() => 'BookingTimeDate(date: $date, time: $time)';
}
