import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import './http_interceptor.dart';

const String baseUrl = 'http://192.168.137.1:8000/api';

class HttpService {
  final client = InterceptedClient.build(
    interceptors: [AuthorizationInterceptor()],
  );

  Future<http.Response> get(String endpoint,
      {Map<String, String>? headers}) async {
    return await client.get('$baseUrl$endpoint'.toUri(), headers: headers);
  }

  Future<http.Response> post(String endpoint,
      {Map<String, String>? headers, Object? body}) async {
    return await client.post('$baseUrl$endpoint'.toUri(),
        headers: headers, body: body);
  }

  Future<http.Response> delete(String endpoint,
      {Map<String, String>? headers, Object? body}) async {
    return await client.delete('$baseUrl$endpoint'.toUri(),
        headers: headers, body: body);
  }

  Future<http.Response> patch(String endpoint,
      {Map<String, String>? headers, Object? body}) async {
    return await client.patch('$baseUrl$endpoint'.toUri(),
        headers: headers, body: body);
  }
}
