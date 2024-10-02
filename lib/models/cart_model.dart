// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:book_heaven/models/book_model.dart';

class CartModel {
  final BookModel book; // The book object
  int quantity; // Quantity of the book in the cart
  final String bookType; // Physical or digital

  CartModel({required this.book, this.quantity = 1, required this.bookType});

  // fromJson constructor to convert JSON to CartModel object
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      book: BookModel.fromJson(json['book']),
      quantity: json['quantity'],
      bookType: json['bookType'],
    );
  }

  // toMap method to convert CartModel object to Map
  Map<String, dynamic> toMap() {
    return {
      'book': book.toJson(),
      'quantity': quantity,
      'bookType': bookType,
    };
  }

  CartModel copyWith({
    BookModel? book,
    int? quantity,
    String? bookType,
  }) {
    return CartModel(
      book: book ?? this.book,
      quantity: quantity ?? this.quantity,
      bookType: bookType ?? this.bookType,
    );
  }
}
