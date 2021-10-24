import 'dart:convert';

import 'package:t_library/models/category.dart';
import 'package:t_library/models/replay.dart';

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

  Future<List<Book>> getTopRated(categoryId) async {
    try {
      final response =
          await http.get('/book/topRated', params: {"category_id": categoryId});
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

  Future<Comment> addComment(String comment, int bookId) async {
    try {
      final response = await http.post('/book/$bookId/add/comment',
          body: {'body': '$comment', 'commentable_id': '1'});
      print(response.body);
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      return Comment(
          id: responseBody['id'] as int,
          body: responseBody['body'] as String,
          replies: []);
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Replay> addReplay(String replay, int commentId) async {
    try {
      final response = await http
          .post('/comment/$commentId/addReplay', body: {'body': '$replay'});
      print(response.body);
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      return Replay.fromJson(responseBody);
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
