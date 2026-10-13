import 'package:ecommerce_app_huma_volve/features/home/domain/use_case/get_categories_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/category_model.dart';
import '../../domain/use_case/get_products_use_case.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  List<HomeCategoryModel> categories = [];

  HomeCubit({
    required this.getProductsUseCase,
    required this.getCategoriesUseCase,
  }) : super(HomeInitial());

  void loadHomeData() async {
    int categoryId = 0;
    emit(CategoriesLoading());
    final categories = await getCategoriesUseCase.invoke();
    categories.fold(
      (failure) {
        emit(CategoriesFailed(failure.failureMessage));
      },
      (categories) {
        categoryId = categories[0].id;
        emit(CategoriesSuccess(categories));
      },
    );
    final products = await getProductsUseCase.invoke(categoryId);
    products.fold(
      (failure) {
        emit(ProductsFailed(failure.failureMessage));
      },
      (products) {
        emit(ProductsSuccess(products));
      },
    );
  }

  Future<void> loadProductsByCategory(int categoryId) async {
    emit(ProductsLoading());

    final products = await getProductsUseCase.invoke(categoryId);
    products.fold(
      (failure) {
        emit(ProductsFailed(failure.failureMessage));
      },
      (products) {
        emit(ProductsSuccess(products));
      },
    );
  }
}
