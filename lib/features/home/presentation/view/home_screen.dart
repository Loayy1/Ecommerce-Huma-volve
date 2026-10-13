import 'package:ecommerce_app_huma_volve/features/home/presentation/view/widgets/category_chip.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view/widgets/product_card.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/presentation/view_model/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dummy_data.dart';
import '../../../../core/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    context.read<HomeCubit>().loadHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: AppTheme.primary,
                          ),
                        ),
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            dummyUser.profilePictureUrl,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Explore',
                      style: Theme.of(context).textTheme.displayLarge
                          ?.copyWith(fontSize: 36),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Best trendy collection!',
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search clothes...',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    BlocBuilder<HomeCubit, HomeStates>(
                      buildWhen: (previous, current) {
                        if (current is ProductsLoading ||
                            current is ProductsSuccess ||
                            current is ProductsFailed) {
                          return false;
                        }
                        return true;
                      },
                      builder: (context, state) {
                        if (state is CategoriesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is CategoriesSuccess) {
                          final categories = state.categories;
                          return SizedBox(
                            height: 44,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                return CategoryChip(
                                  label: categories[index].name,
                                  isSelected: _selectedCategoryIndex == index,
                                  onTap: () {
                                    setState(() {
                                      _selectedCategoryIndex = index;
                                    });
                                    context
                                        .read<HomeCubit>()
                                        .loadProductsByCategory(
                                          categories[index].id,
                                        );
                                  },
                                );
                              },
                            ),
                          );
                        } else if (state is CategoriesFailed) {
                          return Center(child: Text(state.errorMsg));
                        }
                        return const Text("please call method");
                      },
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<HomeCubit, HomeStates>(
              buildWhen: (previous, current) {
                return current is ProductsLoading ||
                    current is ProductsSuccess ||
                    current is ProductsFailed;
              },
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is ProductsSuccess) {
                  final products = state.products;
                  if (products.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(child: Text('No products found.')),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final product = products[index];
                        String imageUrl = 'https://picsum.photos/300/300';
                        if (product.images != null &&
                            product.images!.isNotEmpty) {
                          imageUrl = product.images!.first
                              .replaceAll('[', '')
                              .replaceAll(']', '')
                              .replaceAll('"', '')
                              .trim();
                          if (imageUrl.isEmpty) {
                            imageUrl = 'https://picsum.photos/300/300';
                          }
                        }
                        return ProductCard(
                          product: Product(
                            id: product.id.toString() ?? '',
                            name: product.title ?? '',
                            description: product.description ?? '',
                            price: (product.price ?? 0).toDouble(),
                            imageUrl: imageUrl,
                            colors: const [
                              Colors.black,
                              Colors.blueGrey,
                              Colors.brown,
                            ],
                            sizes: const ['S', 'M', 'L', 'XL'],
                          ),
                        );
                      }, childCount: products.length),
                    ),
                  );
                } else if (state is ProductsFailed) {
                  return SliverFillRemaining(
                    child: Center(child: Text(state.errorMsg)),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
