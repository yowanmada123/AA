import 'package:boilerplate_flutter/model/tournament/create_data_tournamert.dart';
import 'package:boilerplate_flutter/model/user/profile.dart';
import 'package:get/get.dart';

class TournamentController extends GetxController {
  final tournamentdata = CreateDataTournament();
  final selectedProfiles = <Profile>[].obs;
}
