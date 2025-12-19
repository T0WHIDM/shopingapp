import 'package:bloc/bloc.dart';
import 'package:flutter_shop_sample/Data/model/basket_item.dart';
import 'package:flutter_shop_sample/Data/repository/basket_repository.dart';
import 'package:flutter_shop_sample/Data/repository/product_detail_repository.dart';
import 'package:flutter_shop_sample/bloc/product/product_event.dart';
import 'package:flutter_shop_sample/bloc/product/product_state.dart';
import 'package:flutter_shop_sample/di/di.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IproductDetailRepository _productRepository = locator.get();
  final IBasketRepository _basketRepository = locator.get();

  ProductBloc() : super(ProductInitState()) {
    on<ProductInitializeEvent>((event, emit) async {
      emit(ProductLoadingState());

      var productImages = await _productRepository.getProductimage(
        event.productId,
      );
      var productVariant = await _productRepository.getProdutVariants(
        event.productId,
      );
      var productCategory = await _productRepository.getProductCategory(
        event.productId,
      );

      var productProperties = await _productRepository.getProductProperties(
        event.productId,
      );

      emit(
        ProductSuccessResponseState(
          productImages,
          productVariant,
          productCategory,
          productProperties,
        ),
      );
    });

    on<ProductAddToBasket>((event, emit) {
      var basketItem = BasketItem(
        event.product.id,
        event.product.collectionId,
        event.product.thumbnail,
        event.product.discountPrice,
        event.product.price,
        event.product.name,
        event.product.categoryId,
      );

      _basketRepository.addProductToBasket(basketItem);
    });
  }
}
