import 'package:flutter_shop_sample/Data/model/basket_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBasketDataSource {
  Future<void> addProduct(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItem();
  Future<int> getBasketFinalPrice();
}

class BasketLocalDataSource extends IBasketDataSource {
  var box = Hive.box<BasketItem>('basketBox');

  @override
  Future<void> addProduct(BasketItem basketItem) async {
    box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItem() async {
    return box.values.toList();
  }

  @override
  Future<int> getBasketFinalPrice() async {
    var productList = box.values.toList();
    var finalPrice = productList.fold(
      0,
      (accumulator, product) => accumulator + product.realPrice!,
    );
    return finalPrice;
  }
}
