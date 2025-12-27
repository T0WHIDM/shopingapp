import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_sample/Data/repository/basket_repository.dart';
import 'package:flutter_shop_sample/bloc/basket/basket_event.dart';
import 'package:flutter_shop_sample/bloc/basket/basket_state.dart';
import 'package:flutter_shop_sample/di/di.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository = locator.get();

  BasketBloc() : super(BasketInitState()) {
    on<BasketRequestEvent>((event, emit) async {
      var basketItemList = await _basketRepository.getAllBasketItem();
      var basketFinalPrice = await _basketRepository.getBasketFinalPrice();

      emit(BasketDataFetchedState(basketItemList, basketFinalPrice));
    });
  }
}
