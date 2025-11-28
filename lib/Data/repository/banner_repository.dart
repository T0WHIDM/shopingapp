import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/dataSource/banner_data_source.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';
import 'package:flutter_shop_sample/Data/model/banner.dart';

abstract class IBannerRepository {
  Future<Either<String, List<MyBanner>>> getBanner();
}

class BannerRepositoryRemote extends IBannerRepository {
  final IBannnerDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<MyBanner>>> getBanner() async {
    try {
      var response = await _dataSource.getBanner();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
