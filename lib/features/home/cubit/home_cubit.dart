import 'package:ecommerce_app_huma_volve/features/home/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/model/category_model.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeServices homeServices;

  List<CategoryModel> categories = [];

  HomeCubit(this.homeServices) : super(HomeInitial());

  void loadHomeData() async {
    emit(CategoriesLoading());
    try {
      categories = await homeServices.getCategories();
      emit(CategoriesSuccess(categories));
      if (categories.isNotEmpty) {
        await loadProductsByCategory(categories[0].id);
      }
    } catch (ex) {
      emit(CategoriesFailed(ex.toString()));
    }
  }

  Future<void> loadProductsByCategory(int? categoryId) async {
    emit(ProductsLoading());
    try {
      final products = await homeServices.getProducts(categoryId);
      emit(ProductsSuccess(products));
    } catch (ex) {
      emit(ProductsFailed(ex.toString()));
    }
  }
}
