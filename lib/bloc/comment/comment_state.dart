import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/model/comment.dart';

abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentResponseState extends CommentState {
  Either<String, List<Comment>> response;

  CommentResponseState(this.response);
}
