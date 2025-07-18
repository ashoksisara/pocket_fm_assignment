import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/app/theme/theme_constant.dart';
import 'package:pocket_fm_assignment/data/models/cart_item.dart';
import 'package:pocket_fm_assignment/providers/cart_provider.dart';
import 'package:pocket_fm_assignment/widgets/image_widget.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final CartProvider cartProvider;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.cartProvider,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return RepaintBoundary(
      child: Card(
        key: ValueKey(item.product.id),
        margin: const EdgeInsets.only(bottom: ThemeConstant.cardPadding),
        child: Padding(
          padding: const EdgeInsets.all(ThemeConstant.cardPadding),
          child: Row(
            spacing: ThemeConstant.cardPadding,
            children: [
              // Product image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    ThemeConstant.mediumSpacing,
                  ),
                  color: colorScheme.surface,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    ThemeConstant.mediumSpacing,
                  ),
                  child: ImageWidget(imageUrl: item.product.imageUrl),
                ),
              ),
              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: ThemeConstant.smallSpacing,
                  children: [
                    // Product name
                    Text(
                      item.product.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Quantity
                    Text(
                      'Quantity: ${item.quantity}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    // Total price
                    Text(
                      '\$${item.totalPrice.toStringAsFixed(2)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              // Remove button
              IconButton(
                icon: Icon(Icons.delete_outline, color: colorScheme.error),
                iconSize: ThemeConstant.smallIconSize,
                onPressed: onRemove,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
