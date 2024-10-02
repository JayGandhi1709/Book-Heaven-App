import 'dart:developer';

import 'package:book_heaven/models/book_model.dart';
import 'package:book_heaven/models/cart_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  final RxList<CartModel> _allcartItems = <CartModel>[].obs;

  List<CartModel> get allCartBooks => _allcartItems;

  final cartBox = GetStorage("favorite");

  @override
  void onInit() {
    super.onInit();
    getAllCartBooks();
  }

  Future<void> getAllCartBooks() async {
    _allcartItems.clear();
    cartBox.getKeys().forEach((key) {
      var book = CartModel.fromJson(cartBox.read(key));
      _allcartItems.add(book);
    });
  }

  void addToCart(BookModel book, String type) {
    final index = _allcartItems.indexWhere(
        (item) => item.book.title == book.title && item.bookType == type);

    if (index >= 0) {
      _allcartItems[index] = _allcartItems[index]
          .copyWith(quantity: _allcartItems[index].quantity + 1);
    } else {
      _allcartItems.add(CartModel(book: book, bookType: type));
      log("Added ${book.title} to cart");
      cartBox.write(
          book.id.toString(), CartModel(book: book, bookType: type).toMap());
    }
    update();
  }

  void removeFromCart(BookModel book, String type) {
    _allcartItems.removeWhere(
        (item) => item.book.title == book.title && item.bookType == type);
    cartBox.remove(book.id.toString());
    update();
  }

  void updateQuantity(BookModel book, int quantity, String type) {
    final index = _allcartItems.indexWhere(
        (item) => item.book.title == book.title && item.bookType == type);

    if (index >= 0) {
      if (quantity > 0) {
        _allcartItems[index] =
            _allcartItems[index].copyWith(quantity: quantity);
      } else {
        removeFromCart(book, type);
      }
    }
    update();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in _allcartItems) {
      if (item.bookType == 'physical') {
        total += item.book.physicalPrice * item.quantity;
      } else {
        total += item.book.digitalPrice * item.quantity;
      }
    }
    return total;
  }

  void clearCart() {
    _allcartItems.clear();
  }
}
