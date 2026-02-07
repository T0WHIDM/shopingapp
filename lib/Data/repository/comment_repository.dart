import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/dataSource/comment_data_source.dart';
import 'package:flutter_shop_sample/Data/model/comment.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComment(String productId);
  Future<Either<String, String>> postComment(String productId, String text);
}

class CommentRepository extends ICommentRepository {
  final ICommentDataSource dataSource = locator.get();

  @override
  Future<Either<String, List<Comment>>> getComment(String productId) async {
    try {
      var response = await dataSource.getComment(productId);
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> postComment(
    String productId,
    String text,
  ) async {
    try {
      var response = await dataSource.postComment(productId, text);
      return right('نظر شما ثبت شد');
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
