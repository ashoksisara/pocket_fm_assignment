import 'package:flutter/material.dart';

class ThemeConstant {
  // Border Radius
  static const double borderRadius = 12.0;
  static const BorderRadius cardBorderRadius = BorderRadius.all(
    Radius.circular(borderRadius),
  );
  static const BorderRadius topBorderRadius = BorderRadius.vertical(
    top: Radius.circular(borderRadius),
  );

  // Colors
  static const Color primaryColor = Colors.deepPurple;
  static const Color onPrimaryColor = Colors.white;
  static const Color onSurfaceVariant = Colors.white;

  // Spacing
  static const double defaultPadding = 16.0;
  static const double cardPadding = 12.0;
  static const double smallSpacing = 4.0;
  static const double mediumSpacing = 8.0;
  static const double largeSpacing = 16.0;

  // Elevation
  static const double cardElevation = 4.0;
  static const double smallElevation = 2.0;

  // Icon Sizes
  static const double smallIconSize = 24.0;
  static const double largeIconSize = 64.0;

  // Border Width
  static const double borderWidth = 0.5;
}
