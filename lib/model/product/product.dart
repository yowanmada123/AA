// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:boilerplate_flutter/model/place/place_res.dart';

import 'schedule.dart';

class Product {
  final String createdAt;
  final String description;
  late final String id;
  final Place place;
  final String name;
  final int price;
  final List<Schedule> schedules;
  final String updatedAt;
  Product({
    required this.createdAt,
    required this.description,
    required this.id,
    required this.place,
    required this.name,
    required this.price,
    required this.schedules,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created_at': createdAt,
      'description': description,
      'id': id,
      'place': place.toMap(),
      'name': name,
      'price': price,
      'schedules': schedules.map((x) => x.toMap()).toList(),
      'updated_at': updatedAt,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      createdAt: map['created_at'] ?? '',
      description: map['description'] as String,
      id: map['id'] as String,
      place: Place.fromMap(map['place'] as Map<String, dynamic>),
      name: map['name'] as String,
      price: map['price'].toInt() as int,
      schedules: List<Schedule>.from(
        (map['schedules'] as List<dynamic>).map<Schedule>(
          (x) => Schedule.fromMap(x as Map<String, dynamic>),
        ),
      ),
      updatedAt: map['updated_at'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Product(createdAt: $createdAt, description: $description, id: $id, place: $place, name: $name, price: $price, schedules: $schedules, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product && other.createdAt == createdAt && other.description == description && other.id == id && other.place == place && other.name == name && other.price == price && listEquals(other.schedules, schedules) && other.updatedAt == updatedAt;
  }
}
