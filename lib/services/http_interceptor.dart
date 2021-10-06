import 'package:http_interceptor/http_interceptor.dart';

class AuthorizationInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      //String token =
      print('kxchl');
      data.headers['authorization'] = 'Bearer ' + 'token';
    } on Exception catch (e) {
      print(e);
    }
    print('xlkxzh');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
