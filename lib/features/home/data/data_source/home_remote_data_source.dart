import '../model/category_model.dart';
import '../model/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeCategoryModel>> getCategories();
  Future<List<HomeProductModel>> getProducts(
    int? categoryId, {
    int offset = 0,
    int limit = 10,
  });
}