import 'dart:convert';

import '../models/book.dart';
import 'http_service.dart' as http;

const String baseUrl = 'http://192.168.137.1:8000/api';

class BooksService {
  Future<List<Book>> getBooks() async {
    print('csv');

    final response = await http.get('/book');
    print('done');
    print(response.request?.headers);
    print(jsonDecode(response.body));

    return bookFromJson(response.body);
  }
}
