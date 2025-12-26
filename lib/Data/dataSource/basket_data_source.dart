import 'package:flutter_shop_sample/Data/model/basket_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDataSource {
  Future<void> addProduct(BasketItem basketItem);
}

class BasketLocalDataSource extends IBasketDataSource {
  var box = Hive.box<BasketItem>('basketBox');

  @override
  Future<void> addProduct(BasketItem basketItem) async {
    box.add(basketItem);
  }
}
