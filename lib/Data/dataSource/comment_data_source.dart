import 'package:dio/dio.dart';
import 'package:flutter_shop_sample/Data/model/comment.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';
import 'package:flutter_shop_sample/utility/auth_manager.dart';

abstract class ICommentDataSource {
  Future<List<Comment>> getComment(String productId);
  Future<void> postComment(String productId, String text);
}

class CommentDataSource extends ICommentDataSource {
  final Dio dio = locator.get();
  final String userId = AuthManager.getId();

  @override
  Future<List<Comment>> getComment(String productId) async {
    Map<String, dynamic> qParames = {
      'filter': 'product_id = "$productId"',
      'expand': 'user_id',
      'perPage': 800,
    };

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

  @override
  Future<void> postComment(String productId, String text) async {
    try {
      await dio.post(
        'collections/comment/records',
        data: {'product_id': productId, 'text': text, 'user_id': userId},
      );
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unkonwn');
    }
  }
}
