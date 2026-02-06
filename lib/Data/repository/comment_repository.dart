import 'package:dartz/dartz.dart';
import 'package:flutter_shop_sample/Data/dataSource/comment_data_source.dart';
import 'package:flutter_shop_sample/Data/model/comment.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComment(String productId);
}

class CommentRepository extends ICommentRepository {
  @override
  Future<Either<String, List<Comment>>> getComment(String productId) async {
    final ICommentDataSource dataSource = locator.get();

    try {
      var response = await dataSource.getComment(productId);
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
