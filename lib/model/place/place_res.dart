import 'dart:convert';

class Place {
  String address;
  String city;
  String id;
  String images;
  String latitude;
  String longitude;
  String name;

  Place({
    required this.address,
    required this.city,
    required this.id,
    required this.images,
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  @override
  String toString() {
    return 'Place(address: $address, city: $city, id: $id, images: $images, latitude: $latitude, longitude: $longitude, name: $name)';
  }

  factory Place.fromMap(Map<String, dynamic> data) => Place(
        address: data['address']  ?? '',
        city: data['city']  ?? '',
        id: data['id']  ?? '',
        images: data['images']  ?? '',
        latitude: data['latitude']  ?? '',
        longitude: data['longitude']  ?? '',
        name: data['name']  ?? '',
      );

  Map<String, dynamic> toMap() => {
        'address': address,
        'city': city,
        'id': id,
        'images': images,
        'latitude': latitude,
        'longitude': longitude,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Place].
  factory Place.fromJson(String data) {
    return Place.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Place] to a JSON string.
  String toJson() => json.encode(toMap());

  Place copyWith({
    String? address,
    String? city,
    String? id,
    String? images,
    String? latitude,
    String? longitude,
    String? name,
  }) {
    return Place(
      address: address ?? this.address,
      city: city ?? this.city,
      id: id ?? this.id,
      images: images ?? this.images,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
    );
  }
}
