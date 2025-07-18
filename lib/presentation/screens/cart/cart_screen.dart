import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/app/theme/theme_constant.dart';
import 'package:pocket_fm_assignment/data/models/cart_item.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';
import 'widgets/cart_item_widget.dart';
import 'widgets/cart_total.dart';
import 'widgets/empty_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          // No items in cart
          if (cartProvider.items.isEmpty) {
            return const EmptyCartView();
          }

          return Column(
            children: [
              // Cart items
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(ThemeConstant.defaultPadding),
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.items[index];
                    return CartItemWidget(
                      item: item,
                      cartProvider: context.read<CartProvider>(),
                      onRemove: () =>
                          _showRemoveDialog(context, cartProvider, item),
                    );
                  },
                  cacheExtent: 300,
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: true,
                ),
              ),
              // Cart total
              const CartTotal(),
            ],
          );
        },
      ),
    );
  }

  // Show remove dialog
  void _showRemoveDialog(
    BuildContext context,
    CartProvider cartProvider,
    CartItem item,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Item'),
          content: Text('Remove ${item.product.name} from cart?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            ),
            TextButton(
              onPressed: () {
                cartProvider.removeFromCart(item.product);
                Navigator.of(context).pop();
              },
              child: Text('Remove', style: TextStyle(color: colorScheme.error)),
            ),
          ],
        );
      },
    );
  }
}
