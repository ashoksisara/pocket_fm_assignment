import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/app/theme/theme_constant.dart';

class NoProducts extends StatelessWidget {
  const NoProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: ThemeConstant.largeSpacing,
        children: [
          // No products icon
          Icon(
            Icons.shopping_bag_outlined,
            size: ThemeConstant.largeIconSize,
            color: colorScheme.onSurfaceVariant,
          ),
          // No products text
          Text(
            'No products available',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
