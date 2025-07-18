import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/app/theme/theme_constant.dart';
import 'package:pocket_fm_assignment/providers/product_provider.dart';
import 'package:pocket_fm_assignment/widgets/cart_button.dart';
import 'package:pocket_fm_assignment/widgets/custom_error_widget.dart';
import 'package:pocket_fm_assignment/widgets/loader.dart';
import 'package:provider/provider.dart';

import 'widgets/no_products.dart';
import 'widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProductProvider>().loadProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<ProductProvider>().loadMoreProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: const [CartButton()],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          // Loading
          if (productProvider.isLoading) {
            return const Loader();
          }

          // Error
          if (productProvider.error != null) {
            return CustomErrorWidget(error: productProvider.error!);
          }

          // No products
          if (productProvider.products.isEmpty) {
            return const NoProducts();
          }

          // Products
          return _ProductGrid(scrollController: _scrollController);
        },
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  final ScrollController scrollController;

  const _ProductGrid({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return GridView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(ThemeConstant.defaultPadding),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.75,
            crossAxisSpacing: ThemeConstant.defaultPadding,
            mainAxisSpacing: ThemeConstant.defaultPadding,
          ),
          itemCount:
              productProvider.products.length +
              (productProvider.hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == productProvider.products.length) {
              return const _LoadingIndicator();
            }

            return ProductCard(
              key: ValueKey(productProvider.products[index].id),
              product: productProvider.products[index],
            );
          },
          cacheExtent: 500,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: true,
          addSemanticIndexes: false,
        );
      },
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(ThemeConstant.defaultPadding),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
