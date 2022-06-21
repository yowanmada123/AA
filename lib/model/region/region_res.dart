
import 'dart:convert';

class Region {
  final String id;
  final String name;
  final String type;

  Region({

    required this.id,
    required this.name,
    required this.type,
  });

  @override
  String toString() {
    return 'Region(id: $id, name: $name, type: $type)';
    // description: $description,
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      id: map['id'] as String,
      name: map['name'] as String,
      type: map['type'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type
    };
  }

  factory Region.fromJson(String map) {
    return Region.fromMap(json.decode(map) as Map<String, dynamic>);
  }
  
   String toJson() => json.encode(toMap());

  Region copyWith({
    String? id,
    String? name,
    String? type,
  }) {
    return Region(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }
}
