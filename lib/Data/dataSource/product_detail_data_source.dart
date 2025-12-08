import 'package:dio/dio.dart';
import 'package:flutter_shop_sample/Data/model/product_image.dart';
import 'package:flutter_shop_sample/Data/model/product_variant.dart';
import 'package:flutter_shop_sample/Data/model/variant.dart';
import 'package:flutter_shop_sample/Data/model/variants_type.dart';
import 'package:flutter_shop_sample/di/di.dart';
import 'package:flutter_shop_sample/utility/api_exeption.dart';

abstract class IProductDetailDataSource {
  Future<List<ProductImage>> getGallery();
  Future<List<VariantType>> getVariantsType();
  Future<List<Variant>> getVariants();
  Future<List<ProductVariant>> getProductVariants();
}

class ProductDetailDataSource extends IProductDetailDataSource {
  final Dio _dio = locator.get();

  @override
  Future<List<ProductImage>> getGallery() async {
    Map<String, String> qParames = {'filter': 'product_id = "5vvww65pv6nviw6"'};

    try {
      var respones = await _dio.get(
        'collections/gallery/records',
        queryParameters: qParames,
      );

      return respones.data['items']
          .map<ProductImage>(
            (jsonObject) => ProductImage.fromMapJson(jsonObject),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unkown error');
    }
  }

  @override
  Future<List<VariantType>> getVariantsType() async {
    try {
      var response = await _dio.get('collections/variants_type/records');

      print(response.data);

      return response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromjson(jsonObject))
          .toList();
    } catch (ex) {
      throw ApiExeption(0, 'unkown error');
    }
  }

  @override
  Future<List<Variant>> getVariants() async {
    try {
      Map<String, String> qParames = {
        'filter': 'product_id = "5vvww65pv6nviw6"',
      };

      var respones = await _dio.get(
        'collections/variants/records',
        queryParameters: qParames,
      );

      print(respones.data['items']);

      return respones.data['items']
          .map<Variant>((jsonObject) => Variant.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unkown error');
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariants() async {
    var variantTypeList = await getVariantsType();
    var variantList = await getVariants();

    List<ProductVariant> productVariantList = [];

    try {
      for (var variantType in variantTypeList) {
        var variant = variantList
            .where((element) => element.typeId == variantType.id)
            .toList();

        productVariantList.add(ProductVariant(variant, variantType));
      }

      return productVariantList;
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }
}
