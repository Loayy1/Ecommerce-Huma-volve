import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/model/category_model.dart';

import 'package:ecommerce_app_huma_volve/features/home/data/model/product_model.dart';

import '../../../../core/constants/api_endpoints.dart';
import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImp(this.apiClient);

  @override
  Future<List<HomeCategoryModel>> getCategories() async {
    final resp = await apiClient.dio.get(
      ApiEndpoints.categoriesEndPoint,
      queryParameters: {'limit': 20},
    );
    final List jsonData = resp.data;
    final List<HomeCategoryModel> categoriesData = jsonData
        .map((e) => HomeCategoryModel.fromJson(e))
        .toList();
    return categoriesData;
  }

  @override
  Future<List<HomeProductModel>> getProducts(
    int? categoryId, {
    int offset = 0,
    int limit = 10,
  }) async {
    final endpoint = (categoryId != null && categoryId > 0)
        ? "${ApiEndpoints.categoriesEndPoint}/$categoryId/${ApiEndpoints.productsEndPoint}"
        : ApiEndpoints.productsEndPoint;
    final resp = await apiClient.dio.get(
      endpoint,
      queryParameters: {
        'offset': offset,
        'limit': limit,
      },
    );
    final List jsonData = resp.data;
    final List<HomeProductModel> productsData = jsonData
        .map((e) => HomeProductModel.fromJson(e))
        .toList();
    return productsData;
  }
}
