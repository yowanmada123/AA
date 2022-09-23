class CreateDataTournament {
  int? drawSize;
  String? tournamentFormat;
  String? matchFormat;
  String? name;
  String? paymentMethod;
  List<ProfileDetail>? profile;
  String? phoneNumber;
  String? product;
  String? scheduleDate;
  String? scheduleTime;

  CreateDataTournament({this.drawSize, this.tournamentFormat, this.matchFormat, this.name, this.paymentMethod, this.profile, this.phoneNumber, this.product, this.scheduleDate, this.scheduleTime});
}

class ProfileDetail {
  String? profileID;
  ProfileDetail({this.profileID});
}
