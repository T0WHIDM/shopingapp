import 'package:dio/dio.dart';
import 'package:flutter_shop_sample/Data/model/comment.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getComment(String productId);
}

class CommentDataSource extends ICommentDataSource {
  @override
  Future<List<Comment>> getComment(String productId) async {
    final Dio dio = locator.get();
    Map<String, String> qParames = {'filter': 'product_id = "$productId"'};

    try {
      var response = await dio.get(
        'collections/comment/records',
        queryParameters: qParames,
      );
      return response.data['items']
          .map<Comment>((jsonObject) => Comment.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unkown error');
    }
  }
}
