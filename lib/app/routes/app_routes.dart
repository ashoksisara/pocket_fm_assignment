import 'package:flutter/material.dart';

import '../../data/models/product.dart';
import '../../presentation/screens/cart/cart_screen.dart';
import '../../presentation/screens/product/product_details_screen.dart';
import '../../presentation/screens/product/product_list_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String productList = '/product-list';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const ProductListScreen(),
    productList: (context) => const ProductListScreen(),
    productDetails: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Product) {
        return ProductDetailsScreen(product: args);
      }
      // Return to product list if no valid product argument
      return const ProductListScreen();
    },
    cart: (context) => const CartScreen(),
  };
}
