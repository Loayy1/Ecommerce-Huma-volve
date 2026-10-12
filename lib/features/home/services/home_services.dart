import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';

import 'model/category_model.dart';
import 'model/product_model.dart';

class HomeServices {
  final ApiClient apiClient;

  HomeServices(this.apiClient);

  Future<List<CategoryModel>> getCategories() async {
    final resp = await apiClient.dio.get(
      ApiEndpoints.categoriesEndPoint,
      queryParameters: {'limit': 20},
    );
    final List jsonData = resp.data;
    final List<CategoryModel> categoriesData = jsonData
        .map((e) => CategoryModel.fromJson(e))
        .toList();
    return categoriesData;
  }

  Future<List<ProductModel>> getProducts(int? categoryId) async {
    final resp = await apiClient.dio.get(
      "${ApiEndpoints.categoriesEndPoint}/$categoryId/${ApiEndpoints.productsEndPoint}",
    );
    final List jsonData = resp.data;
    final List<ProductModel> productsData = jsonData
        .map((e) => ProductModel.fromJson(e))
        .toList();
    return productsData;
  }
}

//  https://api.escuelajs.co/api/v1/categories?limit=20
