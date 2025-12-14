import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/model/product.dart';

abstract class CategoryProductState {}

class CategoryProductLoadingState extends CategoryProductState {}

class CategoryProductResponseSuccessState extends CategoryProductState {
  Either<String, List<Product>> categoryProductList;

  CategoryProductResponseSuccessState(this.categoryProductList);
}
