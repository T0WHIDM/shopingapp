import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_sample/Data/repository/category_product_repository.dart';
import 'package:flutter_shop_sample/bloc/categoryProduct/category_product_event.dart';
import 'package:flutter_shop_sample/bloc/categoryProduct/category_product_state.dart';
import 'package:flutter_shop_sample/di/di.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final ICategoryProductRepository _repository = locator.get();

  CategoryProductBloc() : super(CategoryProductLoadingState()) {
    on<CatagoryProductInitialize>((event, emit) async {
      var response = await _repository.getProductByCategoryId(event.categoryId);

      emit(CategoryProductResponseSuccessState(response));
    });
  }
}
