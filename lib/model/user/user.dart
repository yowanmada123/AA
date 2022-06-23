// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserRes {
  final String id;
  final String nama;
  UserRes({
    required this.id,
    required this.nama,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
    };
  }

  factory UserRes.fromMap(Map<String, dynamic> map) {
    return UserRes(
      id: map['id'] as String,
      nama: map['nama'] as String,
    );
  }

  @override
  String toString() => 'UserRes(id: $id, nama: $nama)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserRes && other.id == id && other.nama == nama;
  }
}
