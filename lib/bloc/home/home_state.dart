import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/model/banner.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeInitState extends HomeState {}

class HomeSuccessResponseState extends HomeState {
  Either<String, List<MyBanner>> bannerList;

  HomeSuccessResponseState(this.bannerList);
}
