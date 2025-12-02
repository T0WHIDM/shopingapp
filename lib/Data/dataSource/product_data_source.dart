import 'package:dio/dio.dart';
import 'package:flutter_shop_sample/Data/model/product.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';

abstract class IProductDataSource {
  Future<List<Product>> getProduct();
  Future<List<Product>> getHotest();
  Future<List<Product>> getBestSeller();
}

class ProductDataSourceRemote extends IProductDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProduct() async {
    try {
      var response = await _dio.get('collections/products/records');
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unkown error');
    }
  }

  @override
  Future<List<Product>> getBestSeller() async {
    Map<String, String> qParames = {'filter': 'popularity = "Best Seller"'};

    try {
      var response = await _dio.get(
        'collections/products/records',
        queryParameters: qParames,
      );
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unkown error');
    }
  }

  @override
  Future<List<Product>> getHotest() async {
    Map<String, String> qParames = {'filter': 'popularity = "Hotest"'};

    try {
      var response = await _dio.get(
        'collections/products/records',
        queryParameters: qParames,
      );
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unkown error');
    }
  }
}
