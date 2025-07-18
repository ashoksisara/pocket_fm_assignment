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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProductProvider>().loadProducts();
      }
    });
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
            return CustomErrorWidget(
              error: productProvider.error!,
              onRetry: productProvider.loadProducts,
            );
          }

          // No products
          if (productProvider.products.isEmpty) {
            return const NoProducts();
          }

          // Products
          return GridView.builder(
            padding: const EdgeInsets.all(ThemeConstant.defaultPadding),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.75,
              crossAxisSpacing: ThemeConstant.defaultPadding,
              mainAxisSpacing: ThemeConstant.defaultPadding,
            ),
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
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
      ),
    );
  }
}
