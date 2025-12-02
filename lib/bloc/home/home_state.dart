import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/model/banner.dart';
import 'package:flutter_shop_sample/Data/model/category.dart';
import 'package:flutter_shop_sample/Data/model/product.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeInitState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<MyBanner>> bannerList;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;
  Either<String, List<Product>> hotestProduct;
  Either<String, List<Product>> bestSellerProduct;

  HomeRequestSuccessState(
    this.bannerList,
    this.categoryList,
    this.productList,
    this.bestSellerProduct,
    this.hotestProduct,
  );
}
