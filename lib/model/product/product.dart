import 'dart:convert';

import 'schedule.dart';

class Product {
  DateTime? createdAt;
  String? description;
  String? id;
  String? location;
  String? name;
  int? price;
  List<Schedule>? schedules;
  DateTime? updatedAt;

  Product({
    this.createdAt,
    this.description,
    this.id,
    this.location,
    this.name,
    this.price,
    this.schedules,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Product(createdAt: $createdAt, description: $description, id: $id, location: $location, name: $name, price: $price, schedules: $schedules, updatedAt: $updatedAt)';
  }

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        description: data['description'] as String?,
        id: data['id'] as String?,
        location: data['location'] as String?,
        name: data['name'] as String?,
        price: data['price'] as int?,
        schedules: (data['schedules'] as List<dynamic>?)
            ?.map((e) => Schedule.fromMap(e as Map<String, dynamic>))
            .toList(),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'createdAt': createdAt?.toIso8601String(),
        'description': description,
        'id': id,
        'location': location,
        'name': name,
        'price': price,
        'schedules': schedules?.map((e) => e.toMap()).toList(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Product].
  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Product] to a JSON string.
  String toJson() => json.encode(toMap());
}
