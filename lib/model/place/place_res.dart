// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:boilerplate_flutter/page/global_controller.dart';

import 'region_res.dart';

class Place {
  String address;
  Region region;
  String id;
  String images;
  String latitude;
  String longitude;
  String name;

  Place({
    required this.address,
    required this.region,
    required this.id,
    required this.images,
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'region': region.toMap(),
      'id': id,
      'images': images,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      address: map['address'] as String,
      region: Region.fromMap(map['region'] as Map<String, dynamic>),
      id: map['id'] as String,
      images: map['images'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      name: map['name'] as String,
    );
  }

  @override
  String toString() {
    return 'Place(address: $address, region: $region, id: $id, images: $images, latitude: $latitude, longitude: $longitude, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Place && other.address == address && other.region == region && other.id == id && other.images == images && other.latitude == latitude && other.longitude == longitude && other.name == name;
  }

  getImageUrl() {
    return "$mainbaseFile/$images";
  }
}
