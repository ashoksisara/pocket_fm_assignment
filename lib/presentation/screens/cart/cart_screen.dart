import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/app/theme/theme_constant.dart';
import 'package:pocket_fm_assignment/data/models/cart_item.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';
import 'widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          // No items in cart
          if (cartProvider.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: ThemeConstant.largeIconSize,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: ThemeConstant.largeSpacing),
                  Text(
                    'Your cart is empty',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          // Cart items
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(ThemeConstant.defaultPadding),
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.items[index];
                    return CartItemWidget(
                      item: item,
                      cartProvider: cartProvider,
                      onRemove: () =>
                          _showRemoveDialog(context, cartProvider, item),
                    );
                  },
                  cacheExtent: 300,
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: true,
                ),
              ),
              // Total price
              Container(
                padding: const EdgeInsets.all(ThemeConstant.defaultPadding),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outline,
                      width: ThemeConstant.borderWidth,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

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
