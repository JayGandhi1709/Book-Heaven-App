
import 'package:book_heaven/models/book.dart';
import 'package:book_heaven/services/http_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  HttpService httpService = HttpService();
  final cartBox = GetStorage("favorite");

  final RxList<Book> _allCartBooks = <Book>[].obs;

  List<Book> get allCartBooks => _allCartBooks;

  @override
  void onInit() {
    super.onInit();
    getAllCartBooks();
  }

  // store in get storage and get all favorite books
  Future<void> getAllCartBooks() async {
    _allCartBooks.clear();
    cartBox.getKeys().forEach((key) {
      var book = Book.fromJson(cartBox.read(key));
      _allCartBooks.add(book);
    });
  }

  void addRemoveCart(Book book) {
    if (_allCartBooks.contains(book)) {
      cartBox.remove(book.id.toString());
      _allCartBooks.remove(book);
    } else {
      cartBox.write(book.id.toString(), book.toJson());
      _allCartBooks.add(book);
    }
    update();
  }
}
