import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/app/theme/theme_constant.dart';
import 'package:pocket_fm_assignment/data/models/product.dart';
import 'package:pocket_fm_assignment/providers/cart_provider.dart';
import 'package:pocket_fm_assignment/widgets/cart_button.dart';
import 'package:pocket_fm_assignment/widgets/image_widget.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  static const _borderRadius = ThemeConstant.cardBorderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(product.name), actions: const [CartButton()]),
      body: Padding(
        padding: const EdgeInsets.all(ThemeConstant.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: ThemeConstant.largeSpacing,
          children: [
            // Product image
            Center(
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: _borderRadius,
                  color: colorScheme.surface,
                ),
                child: Hero(
                  tag: 'product-${product.id}',
                  child: ClipRRect(
                    borderRadius: _borderRadius,
                    child: ImageWidget(imageUrl: product.imageUrl),
                  ),
                ),
              ),
            ),
            // Product name
            const SizedBox(height: 10),
            Text(
              product.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            // Product description
            Text(
              product.description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            // Product price
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(ThemeConstant.defaultPadding),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: _borderRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price:',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            // Add to cart button
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _addToCart(context, colorScheme),
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add product to cart
  void _addToCart(BuildContext context, ColorScheme colorScheme) {
    context.read<CartProvider>().addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Added to cart!'),
        backgroundColor: colorScheme.primary,
        duration: const Duration(milliseconds: 600),
      ),
    );
  }
}
