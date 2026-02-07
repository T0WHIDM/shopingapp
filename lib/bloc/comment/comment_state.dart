import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/model/comment.dart';

abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentResponseState extends CommentState {
  Either<String, List<Comment>> response;

  CommentResponseState(this.response);
}

class PostCommentLoading extends CommentState {
  final bool isLoading;

  PostCommentLoading(this.isLoading);
}

class PostCommentSuccess extends CommentState {
  final Either<String, String> response;

  PostCommentSuccess(this.response);
}
