import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/app/routes/app_routes.dart';
import 'package:pocket_fm_assignment/app/theme/theme_constant.dart';

import '../../../../data/models/product.dart';
import '../../../../widgets/image_widget.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  static const _borderRadius = ThemeConstant.cardBorderRadius;
  static const _topBorderRadius = ThemeConstant.topBorderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return RepaintBoundary(
      child: Card(
        child: InkWell(
          onTap: () => _navigateToDetails(context),
          borderRadius: _borderRadius,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: _topBorderRadius,
                    color: colorScheme.surface,
                  ),
                  child: ClipRRect(
                    borderRadius: _topBorderRadius,
                    child: ImageWidget(imageUrl: product.imageUrl),
                  ),
                ),
              ),
              // Product details
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(ThemeConstant.cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product name
                      Flexible(
                        child: Text(
                          product.name,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Product price
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Navigate to product details
  void _navigateToDetails(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.productDetails, arguments: product);
  }
}
