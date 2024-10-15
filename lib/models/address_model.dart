import 'dart:convert';

import 'package:flutter/widgets.dart';

class AddressModel {
  String? id; // Optional: To store the address ID from the backend
  String userId; // User ID associated with the address
  String street; // Street name
  String city; // City name
  String state; // State name
  String zipCode; // Zip code
  String contactNumber; // Zip code

  AddressModel({
    this.id,
    required this.userId,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.contactNumber,
  });

  // Factory method to create an Address object from JSON
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
    );
  }

  // Method to convert an Address object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id, // Adjust based on your backend response
      'userId': userId,
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'contactNumber': contactNumber,
    };
  }

  static String fixJsonString(String jsonString) {
    // Adding double quotes around keys and handling multi-word values
    return jsonString.replaceAllMapped(
      RegExp(
          r'(\w+):\s*([^,}]+)'), // Match key and any value that ends with a comma or }
      (match) =>
          '"${match[1]}": "${match[2]}"', // Add quotes around key and value
    );
  }

  // from String to AddressModel
  static AddressModel fromString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(fixJsonString(jsonString));
    return AddressModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
    );
  }

  AddressModel copyWith({
    ValueGetter<String?>? id,
    String? userId,
    String? street,
    String? city,
    String? state,
    String? zipCode,
    String? contactNumber,
  }) {
    return AddressModel(
      id: id != null ? id() : this.id,
      userId: userId ?? this.userId,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      contactNumber: contactNumber ?? this.contactNumber,
    );
  }
}
