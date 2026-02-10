import 'package:dio/dio.dart';
import 'package:flutter_shop_sample/utility/auth_manager.dart';

class DioProvider {
  static Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://startflutter.ir/api/',
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer ${AuthManager.readAuth()}',
        },
      ),
    );

    return dio;
  }

  static Dio createDioWithOutHeader() {
    Dio dio = Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/'));

    return dio;
  }
}
