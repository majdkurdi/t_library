import 'dart:convert';

import '../models/book.dart';
import '../models/comment.dart';
import 'http_service.dart' as http;

// const String baseUrl = 'http://192.168.137.1:8000/api';

class BooksService {
  Future<List<Book>> getBooks() async {
    try {
      final response = await http.get('/book/topRated');
      print('done');
      print(jsonDecode(response.body));
      return bookFromJson(response.body);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future rateBook({required int bookId, required int rate}) async {
    try {
      await http.post('/book/$bookId/rate', body: {'rate': '$rate'});
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Comment>> getComments(int bookId) async {
    try {
      final response = await http.get('/book/$bookId');
      print(response.body);
      return commentsFromJson(response.body);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
