import 'package:flutter/material.dart';
import 'package:pocket_fm_assignment/app/theme/theme_constant.dart';

class CustomErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const CustomErrorWidget({
    super.key,
    required this.error,
    required this.onRetry,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: ThemeConstant.largeSpacing,
        children: [
          // Error icon
          const Icon(
            Icons.error,
            size: ThemeConstant.largeIconSize,
            color: Colors.red,
          ),
          // Error text
          Text(
            error,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
