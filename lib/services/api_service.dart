import 'dart:io';

import 'package:dio/dio.dart';
import 'package:learning_space/services/auth_service.dart';

class ApiService{
  final dio = Dio(BaseOptions(
      baseUrl: "https://ls-api.sagor.dev/",
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
  ));
  ApiService(){
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) =>
          requestInterceptor(options, handler),
      onResponse: (response, handler) => responseInterceptor(response, handler),
      onError: (DioError e, handler) {
          if (e.requestOptions.path != 'login' && e.response?.statusCode == 401) {
            AuthService().logout();
          }else{
            throw Exception(e.message);
          }
        }
    ));
  }

  dynamic requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    if(options.headers['withToken'] != false){
      var token = await AuthService().getToken();
      options.headers.addAll({"Authorization": "Bearer $token"});
    }else{
      options.headers.remove('withToken');
    }
    options.headers.addAll({"Accept": "application/json"});
    print("-----Sending Data-----");
    print(options.uri);
    print(options.headers);
    print(options.data);
    print("---------------------");
    return handler.next(options);
  }

  dynamic responseInterceptor(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }
}