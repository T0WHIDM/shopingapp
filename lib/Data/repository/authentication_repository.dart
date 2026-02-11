import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/dataSource/authentication_data_source.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';
import 'package:flutter_shop_sample/utility/auth_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthenticationRepository {
  Future<Either<String, String>> register(
    String userName,
    String password,
    String passwordConfirm,
  );

  Future<Either<String, String>> login(String userName, String password);
}

class AuthenticationRepository extends IAuthenticationRepository {
  final IAuthenticationDataSource _dataSource = locator.get();
  final SharedPreferences _sharedPref = locator.get();

  @override
  Future<Either<String, String>> register(
    String userName,
    String password,
    String passwordConfirm,
  ) async {
    try {
      await _dataSource.register(userName, password, passwordConfirm);
      return right('ثبت نام انجام شد');
    } on ApiExeption catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, String>> login(String userName, String password) async {
    try {
      String token = await _dataSource.login(userName, password);
      if (token.isNotEmpty) {
        AuthManager.saveToken(token);
        return right('شما وارد شدید');
      } else {
        return left('خطایی در ورود پیش امده است');
      }
    } on ApiExeption catch (ex) {
      return left('${ex.message}');
    }
  }
}
