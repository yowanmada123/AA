// ignore_for_file: public_member_api_docs, sort_constructors_first
class Profile {
  final String identityNumber;
  final String identityType;
  final String address;
  final String createdAt;
  final String dateOfBirth;
  final String placeOfBirth;
  final String email;
  final String fullname;
  final String gender;
  final String id;
  final String phone;
  final String updatedAt;
  final String identityPhoto;
  final String profilePhoto;
  Profile({required this.identityNumber, required this.identityType, required this.address, required this.createdAt, required this.dateOfBirth, required this.placeOfBirth, required this.email, required this.fullname, required this.gender, required this.id, required this.phone, required this.updatedAt, required this.identityPhoto, required this.profilePhoto});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identityNumber': identityNumber,
      'identityType': identityType,
      'address': address,
      'createdAt': createdAt,
      'dateOfBirth': dateOfBirth,
      'placeOfBirth': placeOfBirth,
      'email': email,
      'fullname': fullname,
      'gender': gender,
      'id': id,
      'phone': phone,
      'updatedAt': updatedAt,
      'identityPhoto': identityPhoto,
      'profilePhoto': profilePhoto,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      identityNumber: map['identityNumber'] as String,
      identityType: map['identityType'] as String,
      address: map['address'] as String,
      createdAt: map['createdAt'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      placeOfBirth: map['placeOfBirth'] as String,
      email: map['email'] as String,
      fullname: map['fullname'] as String,
      gender: map['gender'] as String,
      id: map['id'] as String,
      phone: map['phone'] as String,
      updatedAt: map['updatedAt'] as String,
      identityPhoto: map['identityPhoto'] as String,
      profilePhoto: map['profilePhoto'] as String,
    );
  }

  @override
  String toString() {
    return 'Profile(identityNumber: $identityNumber, identityType: $identityType, address: $address, createdAt: $createdAt, dateOfBirth: $dateOfBirth, placeOfBirth: $placeOfBirth, email: $email, fullname: $fullname, gender: $gender, id: $id, phone: $phone, updatedAt: $updatedAt, identityPhoto: $identityPhoto, profilePhoto: $profilePhoto,)';
  }

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;

    return other.identityNumber == identityNumber && other.identityType == identityType && other.address == address && other.createdAt == createdAt && other.dateOfBirth == dateOfBirth && other.placeOfBirth == placeOfBirth && other.email == email && other.fullname == fullname && other.gender == gender && other.id == id && other.phone == phone && other.updatedAt == updatedAt && other.identityPhoto == identityPhoto && other.profilePhoto == profilePhoto;
  }
}
