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
            _ProductImage(product: product),
            // Product name
            const SizedBox(height: 10),
            _ProductName(product: product),
            // Product description
            _ProductDescription(product: product),
            // Product price
            const SizedBox(height: 10),
            _ProductPrice(product: product),
            // Add to cart button
            const Spacer(),
            _AddToCartButton(onPressed: () => _addToCart(context, colorScheme)),
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

class _ProductImage extends StatelessWidget {
  final Product product;

  const _ProductImage({required this.product});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const borderRadius = ThemeConstant.cardBorderRadius;

    return Center(
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: colorScheme.surface,
        ),
        child: Hero(
          tag: 'product-${product.id}',
          child: ClipRRect(
            borderRadius: borderRadius,
            child: ImageWidget(imageUrl: product.imageUrl),
          ),
        ),
      ),
    );
  }
}

class _ProductName extends StatelessWidget {
  final Product product;

  const _ProductName({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Text(
      product.name,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  final Product product;

  const _ProductDescription({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Text(
      product.description,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _ProductPrice extends StatelessWidget {
  final Product product;

  const _ProductPrice({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const borderRadius = ThemeConstant.cardBorderRadius;

    return Container(
      padding: const EdgeInsets.all(ThemeConstant.defaultPadding),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: borderRadius,
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
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddToCartButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text('Add to Cart'),
      ),
    );
  }
}
