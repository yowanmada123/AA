// ignore_for_file: public_member_api_docs, sort_constructors_first

class Turnaments {
  String id;
  String name;

  Turnaments({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory Turnaments.fromMap(Map<String, dynamic> map) {
    return Turnaments(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  @override
  String toString() {
    return 'Turnaments(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Turnaments && other.id == id && other.name == name;
  }

  // getImageUrl() {
  //   return "$mainbaseFile/$images";
  // }
}
