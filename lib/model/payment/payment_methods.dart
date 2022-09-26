
class PaymentMethods {
  final String name;
  final String group;
  final String howToPay;
  final String id;
  final String imageUrl;
  PaymentMethods({
    required this.name,
    required this.group,
    required this.howToPay,
    required this.id,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'group': group,
      'howToPay': howToPay,
      'id': id,
      'imageUrl': imageUrl,
    };
  }

  factory PaymentMethods.fromMap(Map<String, dynamic> map) {
    return PaymentMethods(
      name: map['name'] as String,
      group: map['group'] as String,
      howToPay: map['howToPay'] as String,
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  @override
  String toString() {
    return 'PaymentMethods(name: $name, group: $group, howToPay: $howToPay, id: $id, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PaymentMethods &&
      other.name == name &&
      other.group == group &&
      other.howToPay == howToPay &&
      other.id == id &&
      other.imageUrl == imageUrl;
  }
}