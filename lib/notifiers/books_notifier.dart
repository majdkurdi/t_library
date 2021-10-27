import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/book.dart';
import '../models/category.dart';
import '../models/comment.dart';
import '../models/replay.dart';
import '../services/books_service.dart';
import '../services/category.dart';

final booksProvider =
    ChangeNotifierProvider<BooksNotifier>((ref) => BooksNotifier());

class BooksNotifier extends ChangeNotifier {
  BooksNotifier._internal();
  static BooksNotifier? _instance;

  factory BooksNotifier() {
    if (_instance == null) {
      _instance = BooksNotifier._internal();
    }
    return _instance!;
  }

  List<Category> categories = [];
  List<Book> books = [];
  List<Book> topRatedBooks = [];
  List<Book> orderedBooks = [];
  final _bookService = BooksService();
  final _categoryService = CategoryService();

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

  Future<bool> getTopRatedBooks(int categoryId) async {
    try {
      topRatedBooks = await _bookService.getTopRated(categoryId);
      notifyListeners();
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getOrderedBooks() async {
    try {
      orderedBooks = await _bookService.getOrderedBooks();
      notifyListeners();
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> rateBook({required int bookId, required int rate}) async {
    try {
      await _bookService.rateBook(bookId: bookId, rate: rate);
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

  Future<bool> getCategories() async {
    try {
      categories = await _categoryService.getCategories();
      categories.insert(0, Category(id: 0, name: 'All'));
      notifyListeners();
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<Comment?> addComment(String comment, int bookId) async {
    try {
      return await _bookService.addComment(comment, bookId);
    } on Exception catch (_) {
      return null;
    }
  }

  Future<Replay?> addReplay(String replay, int commentId) async {
    try {
      return await _bookService.addReplay(replay, commentId);
    } on Exception catch (_) {
      return null;
    }
  }
}
