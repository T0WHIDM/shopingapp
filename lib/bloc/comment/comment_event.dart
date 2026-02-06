abstract class CommentEvent {}

class CommentInitialEvent extends CommentEvent {
  String productId;

  CommentInitialEvent(this.productId);
}
