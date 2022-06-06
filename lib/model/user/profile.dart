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
  Profile({
    required this.identityNumber,
    required this.identityType,
    required this.address,
    required this.createdAt,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.email,
    required this.fullname,
    required this.gender,
    required this.id,
    required this.phone,
    required this.updatedAt,
    required this.identityPhoto,
    required this.profilePhoto,
  });

  Map<String, dynamic> toMap() {
    return {
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
      identityNumber: map['identityNumber'] ?? '',
      identityType: map['identityType'] ?? '',
      address: map['address'] ?? '',
      createdAt: map['createdAt'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      placeOfBirth: map['placeOfBirth'] ?? '',
      email: map['email'] ?? '',
      fullname: map['fullname'] ?? '',
      gender: map['gender'] ?? '',
      id: map['id'] ?? '',
      phone: map['phone'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      identityPhoto: map['identityPhoto'] ?? '',
      profilePhoto: map['profilePhoto'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Profile(identityNumber: $identityNumber, identityType: $identityType, address: $address, createdAt: $createdAt, dateOfBirth: $dateOfBirth, placeOfBirth: $placeOfBirth, email: $email, fullname: $fullname, gender: $gender, id: $id, phone: $phone, updatedAt: $updatedAt, identityPhoto: $identityPhoto, profilePhoto: $profilePhoto)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.identityNumber == identityNumber &&
        other.identityType == identityType &&
        other.address == address &&
        other.createdAt == createdAt &&
        other.dateOfBirth == dateOfBirth &&
        other.placeOfBirth == placeOfBirth &&
        other.email == email &&
        other.fullname == fullname &&
        other.gender == gender &&
        other.id == id &&
        other.phone == phone &&
        other.updatedAt == updatedAt &&
        other.identityPhoto == identityPhoto &&
        other.profilePhoto == profilePhoto;
  }
}
