import 'package:dio/dio.dart';
import 'package:flutter_shop_sample/Data/model/product.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';

abstract class ICategoryProductDataSource {
  Future<List<Product>> getProductByCategoryId(String categoryId);
}

class CategoryProductDataSourceRemote extends ICategoryProductDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<Product>> getProductByCategoryId(String categoryId) async {
    try {
      Map<String, String> qParames = {'filter': 'category = "$categoryId"'};

      Response<dynamic> response;

      if (categoryId == 'qnbj8d6b9lzzpn8') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get(
          'collections/products/records',
          queryParameters: qParames,
        );
      }

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
