import 'package:dio/dio.dart';
import 'package:flutter_shop_sample/Data/dataSource/authentication_data_source.dart';
import 'package:flutter_shop_sample/Data/dataSource/banner_data_source.dart';
import 'package:flutter_shop_sample/Data/dataSource/basket_data_source.dart';
import 'package:flutter_shop_sample/Data/dataSource/category_data_source.dart';
import 'package:flutter_shop_sample/Data/dataSource/category_product_data_source.dart';
import 'package:flutter_shop_sample/Data/dataSource/product_data_source.dart';
import 'package:flutter_shop_sample/Data/dataSource/product_detail_data_source.dart';
import 'package:flutter_shop_sample/Data/repository/authentication_repository.dart';
import 'package:flutter_shop_sample/Data/repository/banner_repository.dart';
import 'package:flutter_shop_sample/Data/repository/basket_repository.dart';
import 'package:flutter_shop_sample/Data/repository/category_product_repository.dart';
import 'package:flutter_shop_sample/Data/repository/category_repository.dart';
import 'package:flutter_shop_sample/Data/repository/product_detail_repository.dart';
import 'package:flutter_shop_sample/Data/repository/product_repository.dart';
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
  locator.registerFactory<ICategoryDataSource>(
    () => CategoryDataSourceRemote(),
  );
  locator.registerFactory<IBannnerDataSource>(() => BannerDataSourceRemote());
  locator.registerFactory<IProductDataSource>(() => ProductDataSourceRemote());
  locator.registerFactory<IProductDetailDataSource>(
    () => ProductDetailDataSource(),
  );
  locator.registerFactory<ICategoryProductDataSource>(
    () => CategoryProductDataSourceRemote(),
  );
  locator.registerFactory<IBasketDataSource>(() => BasketLocalDataSource());

  //repositories
  locator.registerFactory<IAuthenticationRepository>(
    () => AuthenticationRepository(),
  );
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepositoryRemote());
  locator.registerFactory<IProductRepository>(() => ProductRepository());
  locator.registerFactory<IproductDetailRepository>(
    () => ProductDetailRepository(),
  );
  locator.registerFactory<ICategoryProductRepository>(
    () => CategoryProductRepository(),
  );
  locator.registerFactory<IBasketRepository>(() => BasketRepository());

  //component
  locator.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
}
