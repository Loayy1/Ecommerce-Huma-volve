import 'package:ecommerce_app_huma_volve/features/home/services/model/category_model.dart';

import '../services/model/product_model.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class CategoriesLoading extends HomeStates {}

class CategoriesSuccess extends HomeStates {
  final List<CategoryModel> categories;

  CategoriesSuccess(this.categories);
}

class CategoriesFailed extends HomeStates {
  final String errorMsg;

  CategoriesFailed(this.errorMsg);
}

class ProductsLoading extends HomeStates {}

class ProductsSuccess extends HomeStates {
  final List<ProductModel> products;

  ProductsSuccess(this.products);
}

class ProductsFailed extends HomeStates {
  final String errorMsg;

  ProductsFailed(this.errorMsg);
}
