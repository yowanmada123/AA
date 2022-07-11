// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:boilerplate_flutter/page/global_controller.dart';

import 'region_res.dart';

class Place {
  String address;
  Region region;
  String description;
  String id;
  String images;
  String image_path;
  double latitude;
  double longitude;
  String name;

  Place({
    required this.address,
    required this.region,
    required this.description,
    required this.id,
    required this.images,
    required this.image_path,
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'region': region.toMap(),
      'description': description,
      'id': id,
      'images': images,
      'image_path': image_path,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      address: map['address'] as String,
      region: Region.fromMap(map['region'] as Map<String, dynamic>),
      description: map['description'] ?? "",
      id: map['id'] as String,
      images: map['images'] as String,
      image_path: map['image_path'] as String,
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      name: map['name'] as String,
    );
  }

  @override
  String toString() {
    return 'Place(address: $address, region: $region, id: $id, images: $images, image_path:$image_path, latitude: $latitude, longitude: $longitude, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Place && other.address == address && other.region == region && other.id == id && other.images == images && other.image_path == image_path && other.latitude == latitude && other.longitude == longitude && other.name == name;
  }

  getImageUrl() {
    return "$mainbaseFile/$images";
  }
}
