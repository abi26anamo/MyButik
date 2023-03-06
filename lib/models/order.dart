import 'dart:convert';

import 'package:flutternodeapp/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final double totalPrice;

  Order(
      {required this.id,
      required this.products,
      required this.quantity,
      required this.address,
      required this.orderedAt,
      required this.userId,
      required this.status,
      required this.totalPrice});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products,
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice':totalPrice
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? "",
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['products']))),
      quantity: List<int>.from(
          map['quantity']?.map((x) => Product.fromMap(x['quantity']))),
      address: map['address'] ?? "",
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      userId: map['userId'] ?? "",
      status: map['status']?.toInt()?? 0,
      totalPrice: map['totalPrice'].toDouble()??0.0,
    );
  }

  String toJson() => jsonEncode(toMap());
  factory Order.fromJson(String source) => Order.fromJson(jsonDecode(source));
}
