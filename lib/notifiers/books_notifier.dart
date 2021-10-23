import 'package:flutter/cupertino.dart';
import '../models/book.dart';
import '../services/books_service.dart';

class BooksNotifier extends ChangeNotifier {
  List<Book> books = [];
  final _bookService = BooksService();

  Future<bool> getBooks() async {
    try {
      books = await _bookService.getBooks();
      notifyListeners();
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> rateBook({required int bookId, required int rate}) async {
    try {
      print(1);
      await _bookService.rateBook(bookId: bookId, rate: rate);
      print(2);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
}
