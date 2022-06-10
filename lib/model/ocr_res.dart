class OcrRes {
  final String name;
  final String address;
  final String birthDate;
  final String birthPlace;
  final String gender;
  final String identityNumber;
  OcrRes({
    required this.name,
    required this.address,
    required this.birthDate,
    required this.birthPlace,
    required this.gender,
    required this.identityNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'birthDate': birthDate,
      'birthPlace': birthPlace,
      'gender': gender,
      'identityNumber': identityNumber,
    };
  }

  factory OcrRes.fromMap(Map<String, dynamic> map) {
    return OcrRes(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      birthDate: map['birthDate'] ?? '',
      birthPlace: map['birthPlace'] ?? '',
      gender: map['gender'] ?? '',
      identityNumber: map['identityNumber'] ?? '',
    );
  }

  @override
  String toString() {
    return 'OcrRes(name: $name, address: $address, birthDate: $birthDate, birthPlace: $birthPlace, gender: $gender, identityNumber: $identityNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OcrRes &&
        other.name == name &&
        other.address == address &&
        other.birthDate == birthDate &&
        other.birthPlace == birthPlace &&
        other.gender == gender &&
        other.identityNumber == identityNumber;
  }
}
