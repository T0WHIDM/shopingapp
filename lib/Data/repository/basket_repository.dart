import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/dataSource/basket_data_source.dart';
import 'package:flutter_shop_sample/Data/model/basket_item.dart';
import 'package:flutter_shop_sample/di/di.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
}

class BasketRepository extends IBasketRepository {
  final IBasketDataSource _dataSource = locator.get();

  @override
  Future<Either<String, String>> addProductToBasket(
    BasketItem basketItem,
  ) async {
    try {
      _dataSource.addProduct(basketItem);
      return Right('محصول به سبد خرید اضافه شد');
    } catch (e) {
      return Left('خطا در افزودن محصول به سبد خرید');
    }
  }
}
