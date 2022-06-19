import 'dart:convert';

class Transaction {
  int amount;
  String createdAt;
  String id;
  String payment_id;
  String payment_method;
  String phone_number;
  String product_id;
  String scheduled_date;
  String scheduled_time;
  String status;
  String updatedAt;

  Transaction({
    required this.amount,
    required this.createdAt,
    required this.id,
    required this.payment_id,
    required this.payment_method,
    required this.phone_number,
    required this.product_id,
    required this.scheduled_date,
    required this.scheduled_time,
    required this.status,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'Transaction(amount: $amount, createdAt: $createdAt, id: $id, payment_id: $payment_id, payment_method: $payment_method, phone_number: $phone_number, product_id: $product_id, scheduled_date: $scheduled_date, scheduled_time: $scheduled_time, status: $status, updatedAt: $updatedAt)';
  }

  factory Transaction.fromMap(Map<String, dynamic> map) => Transaction(
        amount: map['amount'] ?? '',
        createdAt: map['createdAt'] ?? '',
        id: map['id'] ?? '',
        payment_id: map['payment_id'] ?? '',
        payment_method: map['payment_method'] ?? '',
        phone_number: map['phone_number'] ?? '',
        product_id: map['product_id'] ?? '',
        scheduled_date: map['scheduled_date'] ?? '',
        scheduled_time: map['scheduled_time'] ?? '',
        status: map['status'] ?? '',
        updatedAt: map['updatedAt'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'amount': amount,
        'createdAt': createdAt,
        'id': id,
        'payment_id': payment_id,
        'payment_method': payment_method,
        'phone_number': phone_number,
        'product_id': product_id,
        'scheduled_date': scheduled_date,
        'scheduled_time': scheduled_time,
        'status': status,
        'updatedAt': updatedAt,
      };

  factory Transaction.fromJson(String map) {
    return Transaction.fromMap(json.decode(map) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  Transaction copyWith({
    int? amount,
    String? createdAt,
    String? id,
    String? payment_id,
    String? payment_method,
    String? phone_number,
    String? product_id,
    String? scheduled_date,
    String? scheduled_time,
    String? status,
    String? updatedAt,
  }) {
    return Transaction(
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt, 
      id: id ?? this.id, 
      payment_id: payment_id ?? this.payment_id, 
      payment_method: payment_method ?? this.payment_method, 
      phone_number: phone_number ?? this.phone_number, 
      product_id: product_id ?? this.product_id, 
      scheduled_date: scheduled_date ?? this.scheduled_date, 
      scheduled_time: scheduled_time ?? this.scheduled_time, 
      status: status ?? this.status, 
      updatedAt: updatedAt ?? this.updatedAt
    );
  }
}
