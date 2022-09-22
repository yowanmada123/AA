import 'package:boilerplate_flutter/model/product/product.dart';
import 'package:boilerplate_flutter/model/user/profile.dart';

class CreateDataTournament {
  int? drawSize;
  String? tournamentFormat;
  String? matchFormat;
  String? name;
  String? paymentMethod;
  Profile? profile;
  String? phoneNumber;
  String? product;
  String? scheduleDate;
  String? scheduleTime;

  CreateDataTournament({this.drawSize,this.tournamentFormat, this.matchFormat,this.name,  this.paymentMethod, this.profile, this.phoneNumber, this.product, this.scheduleDate, this.scheduleTime});
}
