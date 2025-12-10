import 'package:bloc/bloc.dart';
import 'package:flutter_shop_sample/Data/repository/product_detail_repository.dart';
import 'package:flutter_shop_sample/bloc/product/product_event.dart';
import 'package:flutter_shop_sample/bloc/product/product_state.dart';
import 'package:flutter_shop_sample/di/di.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IproductDetailRepository _productRepository = locator.get();

  ProductBloc() : super(ProductInitState()) {
    on<ProductInitializeEvent>((event, emit) async {
      emit(ProductLoadingState());

      var productImages = await _productRepository.getProductimage(
        event.productId,
      );
      var productVariant = await _productRepository.getProdutVariants();
      var productCategory = await _productRepository.getProductCategory(
        event.productId,
      );

      emit(
        ProductResponseState(productImages, productVariant, productCategory),
      );
    });
  } 
}
