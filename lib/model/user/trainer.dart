// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// class Trainers {
//   final String createdAt;
//   final String id;
//   final String image_url;
//   final String name;
//   final String price;
//   final String updatedAt;
//   };

// {
//           "createdAt": "2022-09-22T12:59:51.550Z",
//           "id": "70cab708-ef81-438e-b41e-35534cecb94a",
//           "image_url": "string",
//           "name": "test",
//           "price": 10000,
//           "updatedAt": "2022-09-22T12:59:51.550Z"
//         }
class Trainers {
  String? createdAt;
  String? id;
  String? imageUrl;
  String? name;
  int? price;
  String? updatedAt;

  Trainers({
    this.createdAt,
    this.id,
    this.imageUrl,
    this.name,
    this.price,
    this.updatedAt,
  });

  factory Trainers.fromJson(Map<String, dynamic> json) => Trainers(
        createdAt: json['createdAt'] as String?,
        id: json['id'] as String?,
        imageUrl: json['image_url'] as String?,
        name: json['name'] as String?,
        price: json['price'] as int?,
        updatedAt: json['updatedAt'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'id': id,
        'image_url': imageUrl,
        'name': name,
        'price': price,
        'updatedAt': updatedAt,
      };

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'updatedAt': updatedAt,
    };
  }

  

  factory Trainers.fromMap(Map<String, dynamic> map) {
    return Trainers(
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as int : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  
}
