abstract class CommentEvent {}

class CommentInitialEvent extends CommentEvent {
  final String productId;

  CommentInitialEvent(this.productId);
}

class CommentPostEvent extends CommentEvent{
  final String productId;
  final String text;

  CommentPostEvent(this.productId, this.text);
}
