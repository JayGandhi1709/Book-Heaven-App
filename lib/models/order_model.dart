import 'dart:convert';

import 'package:book_heaven/models/address_model.dart';
import 'package:book_heaven/models/cart_model.dart';

class OrderModel {
  String? id;
  String userId;
  String orderDate;
  String deliveryAddress;
  double totalPrice;
  String paymentMethod;
  String orderStatus;
  bool isDigitalOrder;
  List<CartModel> orderItems;

  OrderModel({
    this.id,
    required this.userId,
    required this.orderDate,
    required this.deliveryAddress,
    required this.totalPrice,
    required this.paymentMethod,
    required this.orderStatus,
    required this.isDigitalOrder,
    required this.orderItems,
  });

  // Factory method to create an Order from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      orderDate: json['orderDate'] ?? '',
      // deliveryAddress: json['deliveryAddress'] ?? '',
      deliveryAddress: json['deliveryAddress'] ?? '',
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      paymentMethod: json['paymentMethod'] ?? '',
      orderStatus: json['orderStatus'] ?? '',
      isDigitalOrder: json['isDigitalOrder'] ?? false,
      orderItems: (json['orderItems'] as List?)
              ?.map((item) => CartModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  // Method to convert Order to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orderDate': orderDate,
      'deliveryAddress': deliveryAddress,
      'totalPrice': totalPrice,
      'paymentMethod': paymentMethod,
      'orderStatus': orderStatus,
      'isDigitalOrder': isDigitalOrder,
      'orderItems': orderItems.map((item) => item.toJson()).toList(),
    };
  }
}
