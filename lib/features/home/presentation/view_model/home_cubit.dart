import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entites/home_product_entity.dart';
import '../../domain/use_case/get_categories_use_case.dart';
import '../../domain/use_case/get_products_use_case.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;

  int? currentCategoryId;
  int offset = 0;
  static const int limit = 10;
  bool hasMore = true;
  bool isLoadingMore = false;
  final List<HomeProductEntity> products = [];

  HomeCubit({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
  }) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(CategoriesLoading());
    final categoriesResult = await getCategoriesUseCase.invoke();
    categoriesResult.fold(
      (failure) {
        emit(CategoriesFailed(failure.failureMessage));
      },
      (categories) {
        if (categories.isNotEmpty) {
          currentCategoryId = categories[0].id;
        }
        emit(CategoriesSuccess(categories));
      },
    );

    await loadProducts(isInitial: true);
  }

  Future<void> loadProductsByCategory(int categoryId) async {
    currentCategoryId = categoryId;
    await loadProducts(isInitial: true);
  }

  Future<void> loadProducts({bool isInitial = false}) async {
    if (isInitial) {
      offset = 0;
      hasMore = true;
      isLoadingMore = false;
      products.clear();
      emit(ProductsLoading());
    }

    final result = await getProductsUseCase.invoke(
      currentCategoryId,
      offset: offset,
      limit: limit,
    );

    result.fold(
      (failure) {
        emit(ProductsFailed(failure.failureMessage));
      },
      (newProducts) {
        if (newProducts.length < limit) {
          hasMore = false;
        }
        offset += newProducts.length;
        products.addAll(newProducts);
        emit(ProductsSuccess(List.unmodifiable(products), hasMore: hasMore));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore || !hasMore || state is ProductsLoading) return;

    isLoadingMore = true;
    emit(ProductsPaginationLoading());

    final result = await getProductsUseCase.invoke(
      currentCategoryId,
      offset: offset,
      limit: limit,
    );

    result.fold(
      (failure) {
        isLoadingMore = false;
        emit(ProductsPaginationFailed(failure.failureMessage));
      },
      (newProducts) {
        isLoadingMore = false;
        if (newProducts.length < limit) {
          hasMore = false;
        }
        offset += newProducts.length;
        products.addAll(newProducts);
        emit(ProductsSuccess(List.unmodifiable(products), hasMore: hasMore));
      },
    );
  }

  Future<void> refreshProducts() async {
    await loadProducts(isInitial: true);
  }
}
