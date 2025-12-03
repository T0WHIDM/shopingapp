import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/model/product_image.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> getProductImages;

  ProductResponseState(this.getProductImages);
}
