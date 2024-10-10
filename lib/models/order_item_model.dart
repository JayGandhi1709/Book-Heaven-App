import 'package:book_heaven/models/book_model.dart';

class OrderItem {
  BookModel book;
  int quantity;
  String bookType;

  OrderItem({
    required this.book,
    required this.quantity,
    required this.bookType,
  });

  // Factory method to create an OrderItem from JSON
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      book: BookModel.fromJson(json['book']),
      quantity: json['quantity'],
      bookType: json['bookType'],
    );
  }

  // Method to convert OrderItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'book': book.toJson(),
      'quantity': quantity,
      'bookType': bookType,
    };
  }
}
