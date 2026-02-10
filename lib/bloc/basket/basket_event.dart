abstract class BasketEvent {}

class BasketRequestEvent extends BasketEvent {}

class BasketRemoveProductEvent extends BasketEvent {
  int index;
  BasketRemoveProductEvent(this.index);
}
