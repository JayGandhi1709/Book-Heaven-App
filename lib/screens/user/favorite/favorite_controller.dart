import 'dart:developer';

import 'package:book_heaven/models/book_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteController extends GetxController {
  final favoriteBox = GetStorage("favorite");

  final RxList<BookModel> _allFavoriteBooks = <BookModel>[].obs;

  List<BookModel> get allFavoriteBooks => _allFavoriteBooks;

  @override
  void onInit() {
    super.onInit();
    getAllFavoriteBooks();
  }

  // Retrieve all favorite books from GetStorage
  Future<void> getAllFavoriteBooks() async {
    // _allFavoriteBooks.clear();
    log("Comming in Favourite Controller");
    log(favoriteBox.getKeys().toString());
    final keys = favoriteBox.getKeys();
    if (keys.isNotEmpty) {
      for (var key in keys) {
        var bookData = favoriteBox.read(key);
        if (bookData != null) {
          var book = BookModel.fromJson(bookData);
          _allFavoriteBooks.add(book);
        }
      }
    }
  }

  // Add or remove a book from favorites
  void addRemoveFavorite(BookModel book) {
    if (_allFavoriteBooks.contains(book)) {
      favoriteBox.remove(book.id.toString());
      _allFavoriteBooks.remove(book);
    } else {
      favoriteBox.write(book.id.toString(), book.toJson());
      _allFavoriteBooks.add(book);
    }
    update();
  }

  // Check if a book is marked as favorite
  bool isFavorite(BookModel book) {
    log(_allFavoriteBooks.contains(book).toString(),name: "isFav",);
    return _allFavoriteBooks.contains(book);
  }
}
