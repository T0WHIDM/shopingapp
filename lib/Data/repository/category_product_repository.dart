import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/dataSource/category_product_data_source.dart';
import 'package:flutter_shop_sample/Data/model/product.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<Product>>> getProductByCategoryId(
    String categoryId,
  );
}

class CategoryProductRepository extends ICategoryProductRepository {
  final ICategoryProductDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProductByCategoryId(
    String categoryId,
  ) async {
    try {
      var response = await _dataSource.getProductByCategoryId(categoryId);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
