import 'package:dio/dio.dart';
import 'package:flutter_shop_sample/Data/dataSource/authentication_data_source.dart';
import 'package:flutter_shop_sample/Data/repository/authentication_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'https://startflutter.ir/api/')),
  );

  //dataSources
  locator.registerFactory<IAuthenticationDataSource>(
    () => AuthenticationRemote(),
  );

  //repositories
  locator.registerFactory<IAuthenticationRepository>(
    () => AuthenticationRepository(),
  );

  //component
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
}
