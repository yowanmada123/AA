import 'package:boilerplate_flutter/model/product/product.dart';
import 'package:boilerplate_flutter/model/user/profile.dart';

class CreateDataTournament {
  final int drawSize;
  final String format;
  final String match;
  final String name;
  String? paymentMethod;
  Profile? profile;
  String? phoneNumber;
  Product? product;
  String? scheduleDate;
  String? scheduleTime;

  CreateDataTournament({required this.drawSize,required this.format, required this.match,required this.name,  this.paymentMethod, this.profile, this.phoneNumber, this.product, this.scheduleDate, this.scheduleTime});
}
