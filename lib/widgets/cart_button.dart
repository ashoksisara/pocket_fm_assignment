import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../app/routes/app_routes.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CartProvider, int>(
      selector: (context, cart) => cart.itemCount,
      builder: (context, itemCount, child) {
        // Cart button
        return IconButton(
          icon: Badge(
            label: Text(itemCount.toString()),
            child: const Icon(Icons.shopping_cart),
          ),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.cart),
        );
      },
    );
  }
}
