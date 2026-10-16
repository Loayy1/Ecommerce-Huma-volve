import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entites/home_product_entity.dart';

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
  final bool hasMore;

  ProductsSuccess(this.products, {this.hasMore = true});
}

class ProductsFailed extends HomeStates {
  final String errorMsg;

  ProductsFailed(this.errorMsg);
}

class ProductsPaginationLoading extends HomeStates {}

class ProductsPaginationFailed extends HomeStates {
  final String errorMsg;

  ProductsPaginationFailed(this.errorMsg);
}
