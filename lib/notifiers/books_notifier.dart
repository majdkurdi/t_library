import 'package:flutter/cupertino.dart';
import '../models/book.dart';
import '../services/books_service.dart';

class BooksNotifier extends ChangeNotifier {
  List<Book> books = [];
  final bookService = BooksService();

  Future getBooks() async {
    try {
      books = await bookService.getBooks();
      return null;
    } on Exception catch (e) {
      return e;
    }
  }
}
