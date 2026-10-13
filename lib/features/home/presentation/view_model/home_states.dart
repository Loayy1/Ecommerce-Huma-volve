import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';

import '../../data/model/category_model.dart';
import '../../data/model/product_model.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class CategoriesLoading extends HomeStates {}

class CategoriesSuccess extends HomeStates {
  final List<HomeCategoryEntity> categories;

  CategoriesSuccess(this.categories);
}

class CategoriesFailed extends HomeStates {
  final String errorMsg;

  CategoriesFailed(this.errorMsg);
}

class ProductsLoading extends HomeStates {}

class ProductsSuccess extends HomeStates {
  final List<HomeProductEntity> products;

  ProductsSuccess(this.products);
}

class ProductsFailed extends HomeStates {
  final String errorMsg;

  ProductsFailed(this.errorMsg);
}
