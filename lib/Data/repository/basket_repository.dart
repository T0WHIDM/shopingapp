import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/dataSource/basket_data_source.dart';
import 'package:flutter_shop_sample/Data/model/basket_item.dart';
import 'package:flutter_shop_sample/di/di.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> addProductToBasket(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getAllBasketItem();
  Future<int> getBasketFinalPrice();
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

  @override
  Future<Either<String, List<BasketItem>>> getAllBasketItem() async {
    try {
      var basketItemList = await _dataSource.getAllBasketItem();
      return Right(basketItemList);
    } catch (e) {
      return Left('خطا در نمایش محصولات!!');
    }
  }

  @override
  Future<int> getBasketFinalPrice() async {
    return _dataSource.getBasketFinalPrice();
  }
}
