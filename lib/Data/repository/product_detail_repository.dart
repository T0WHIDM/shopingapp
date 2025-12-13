import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/dataSource/product_detail_data_source.dart';
import 'package:flutter_shop_sample/Data/model/category.dart';
import 'package:flutter_shop_sample/Data/model/product_image.dart';
import 'package:flutter_shop_sample/Data/model/product_variant.dart';
import 'package:flutter_shop_sample/Data/model/properties.dart';
import 'package:flutter_shop_sample/Data/model/variants_type.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';

abstract class IproductDetailRepository {
  Future<Either<String, List<ProductImage>>> getProductimage(String product);
  Future<Either<String, List<VariantType>>> getVariantsType();
  Future<Either<String, List<ProductVariant>>> getProdutVariants(
    String productId,
  );
  Future<Either<String, Category>> getProductCategory(String categoryId);
  Future<Either<String, List<Property>>> getProductProperties(String productId);
}

class ProductDetailRepository extends IproductDetailRepository {
  final IProductDetailDataSource _dataSource = locator.get();

  @override
  Future<Either<String, List<ProductImage>>> getProductimage(
    String product,
  ) async {
    try {
      var response = await _dataSource.getGallery(product);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<VariantType>>> getVariantsType() async {
    try {
      var response = await _dataSource.getVariantsType();
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getProdutVariants(
    String productId,
  ) async {
    try {
      var response = await _dataSource.getProductVariants(productId);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, Category>> getProductCategory(String categoryId) async {
    try {
      var response = await _dataSource.getProductCategory(categoryId);
      return right(response);
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<Property>>> getProductProperties(
    String productId,
  ) async {
    try {
      var response = await _dataSource.getProductProperties(productId);
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
