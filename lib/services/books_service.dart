import 'package:http_interceptor/http/http.dart';
import './http_interceptor.dart';
import '../models/book.dart';

const String baseUrl = 'http://192.168.137.1:8000/api';

mixin BooksService {
  static Future<List<Book>> getBooks() async {
    final client =
        InterceptedClient.build(interceptors: [AuthorizationInterceptor()]);
    final response = await client.get(Uri.parse('$baseUrl/book'));
    print(response.request?.headers);
    return bookFromJson(response.body);
  }
}
