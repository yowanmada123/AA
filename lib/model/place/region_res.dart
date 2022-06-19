
class Region {
  final String id;
  final String name;
  final String type;
  Region({
    required this.id,
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
    };
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      id: map['id'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
    );
  }

  @override
  String toString() => 'Region(id: $id, name: $name, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Region &&
      other.id == id &&
      other.name == name &&
      other.type == type;
  }
}