import 'package:flutter/cupertino.dart';
import 'package:t_library/models/comment.dart';
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

  Future<List<Comment>?> getComments(int bookId) async {
    try {
      return (await _bookService.getComments(bookId));
    } on Exception catch (_) {
      return null;
    }
  }
}
