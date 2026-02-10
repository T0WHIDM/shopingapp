import 'package:dio/dio.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';
import 'package:flutter_shop_sample/utility/dio_provider.dart';

abstract class IAuthenticationDataSource {
  Future<void> register(
    String userName,
    String password,
    String passwordConfirm,
  );

  Future<String> login(String userName, String password);
}

class AuthenticationRemote implements IAuthenticationDataSource {
  final Dio _dio = DioProvider.createDioWithOutHeader();

  @override
  Future<void> register(
    String userName,
    String password,
    String passwordConfirm,
  ) async {
    try {
      final response = await _dio.post(
        'collections/users/records',
        data: {
          'username': userName,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unkonwn error');
    }
  }

  @override
  Future<String> login(String userName, String password) async {
    try {
      final response = await _dio.post(
        'collections/users/auth-with-password',
        data: {'identity': userName, 'password': password},
      );
      if (response.statusCode == 200) {
        return response.data?['token'];
      }
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unkonwn error');
    }
    return '';
  }
}
