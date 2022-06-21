
import 'dart:convert';

class Region {
  final String address;
  // final String description;
  // final Description description;
  final String id;
  final String images;
  final String latitude;
  final String longitude;
  final String name;
  Region({
    required this.address,
    // required this.description,
    required this.id,
    required this.images,
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  @override
  String toString() {
    return 'Region(address: $address,  id: $id, images: $images, latitude: $latitude, longitude: $longitude, name: $name)';
    // description: $description,
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      address: map['address'] as String,
      // description: map['description'] as String,
      // description: Description.fromMap(map['description'] as Map<String,dynamic>),
      id: map['id'] as String,
      images: map['images'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      // 'description': description,
      // 'description': description.toMap(),
      'id': id,
      'images': images,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
    };
  }

  factory Region.fromJson(String map) {
    return Region.fromMap(json.decode(map) as Map<String, dynamic>);
  }
  
   String toJson() => json.encode(toMap());

  Region copyWith({
    String? address,
    // String? description,
  // final Description description;
    String? id,
    String? images,
    String? latitude,
    String? longitude,
    String? name,
  }) {
    return Region(
      address: address ?? this.address,
      // description: description ?? this.description,
      // description: Description.fromMap(map['description'] as Map<String,dynamic>),
      id: id ?? this.id,
      images: images ?? this.images,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,

    );
  }
}
