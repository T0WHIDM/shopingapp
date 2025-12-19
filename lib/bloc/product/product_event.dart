import 'package:flutter_shop_sample/Data/model/product.dart';

abstract class ProductEvent {}

class ProductInitializeEvent extends ProductEvent {
  String productId;
  String categoryId;

  ProductInitializeEvent(this.productId, this.categoryId);
}

