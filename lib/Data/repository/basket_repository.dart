import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/dataSource/basket_data_source.dart';
import 'package:flutter_shop_sample/Data/model/basket_item.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
}

class BasketRepository extends IBasketRepository {
  final IBasketDataSource dataSource = locator.get();

  @override
  Future<Either<String, String>> addProductToBasket(
    BasketItem basketItem,
  ) async {
    try {
      dataSource.addProduct(basketItem);
      return right('محصول به سبد خرید اضافه شد');
    } on ApiExeption catch (e) {
      return left(e.message ?? 'خطا در افزودن محصول به سبد خرید');
    }
  }
}
