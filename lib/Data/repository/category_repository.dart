import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/dataSource/category_data_source.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';
import 'package:flutter_shop_sample/Data/model/category.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> getCategories();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      var response = await _dataSource.getCategories();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
