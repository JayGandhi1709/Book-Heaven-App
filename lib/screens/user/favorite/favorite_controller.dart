
import 'package:book_heaven/models/book.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteController extends GetxController {
  HttpService httpService = HttpService();
  final favoriteBox = GetStorage("favorite");

  final RxList<Book> _allFavoriteBooks = <Book>[].obs;

  List<Book> get allFavoriteBooks => _allFavoriteBooks;

  @override
  void onInit() {
    super.onInit();
    getAllFavoriteBooks();
  }

  // store in get storage and get all favorite books
  Future<void> getAllFavoriteBooks() async {
    _allFavoriteBooks.clear();
    favoriteBox.getKeys().forEach((key) {
      var book = Book.fromJson(favoriteBox.read(key));
      _allFavoriteBooks.add(book);
    });
  }

  void addRemoveFavorite(Book book) {
    if (_allFavoriteBooks.contains(book)) {
      favoriteBox.remove(book.id.toString());
      _allFavoriteBooks.remove(book);
    } else {
      favoriteBox.write(book.id.toString(), book.toJson());
      _allFavoriteBooks.add(book);
    }
    update();
  }

  bool isFavorite(Book book) {
    return _allFavoriteBooks.contains(book);
  }
}
