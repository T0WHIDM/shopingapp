import 'package:bloc/bloc.dart';
import 'package:flutter_shop_sample/Data/repository/banner_repository.dart';
import 'package:flutter_shop_sample/Data/repository/category_repository.dart';
import 'package:flutter_shop_sample/bloc/home/home_event.dart';
import 'package:flutter_shop_sample/bloc/home/home_state.dart';
import 'package:flutter_shop_sample/di/di.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final ICategoryRepository _categoryRepository = locator.get();

  HomeBloc() : super(HomeInitState()) {
    on<HomeGetInitializeData>((event, emit) async {
      emit(HomeLoadingState());
      var bannerList = await _bannerRepository.getBanner();
      var categoryList = await _categoryRepository.getCategories();

      emit(HomeSuccessResponseState(bannerList, categoryList));
    });
  }
}
