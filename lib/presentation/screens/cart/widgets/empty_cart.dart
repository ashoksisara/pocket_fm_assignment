import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/app/theme/theme_constant.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: ThemeConstant.largeSpacing,
        children: [
          // Empty cart icon
          Icon(
            Icons.shopping_cart_outlined,
            size: ThemeConstant.largeIconSize,
            color: colorScheme.onSurfaceVariant,
          ),
          // Empty cart text
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
}
