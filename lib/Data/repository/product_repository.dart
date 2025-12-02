import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/dataSource/product_data_source.dart';
import 'package:flutter_shop_sample/Data/model/product.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProduct();
  Future<Either<String, List<Product>>> getHotest();
  Future<Either<String, List<Product>>> getBestSeller();
}

class ProductRepository extends IProductRepository {
  final IProductDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProduct() async {
    try {
      var response = await _dataSource.getProduct();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Product>>> getBestSeller() async {
    try {
      var response = await _dataSource.getBestSeller();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Product>>> getHotest() async {
    try {
      var response = await _dataSource.getHotest();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
