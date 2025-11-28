import 'package:dio/dio.dart';
import 'package:flutter_shop_sample/Data/model/banner.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';

abstract class IBannnerDataSource {
  Future<List<MyBanner>> getBanner();
}

class BannerDataSourceRemote extends IBannnerDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<MyBanner>> getBanner() async {
    try {
      var respones = await _dio.get('collections/banner/records');

      return respones.data['items']
          .map<MyBanner>((jsonObject) => MyBanner.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unkown error');
    }
  }
}
