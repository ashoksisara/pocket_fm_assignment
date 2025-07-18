import 'package:flutter/material.dart';
import 'theme_constant.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: ThemeConstant.primaryColor),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: ThemeConstant.primaryColor,
      foregroundColor: ThemeConstant.onPrimaryColor,
    ),
    iconTheme: const IconThemeData(
      size: ThemeConstant.largeIconSize,
      color: ThemeConstant.onSurfaceVariant,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: ThemeConstant.cardBorderRadius,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: ThemeConstant.largeSpacing,
        ),
        backgroundColor: ThemeConstant.primaryColor,
        foregroundColor: ThemeConstant.onPrimaryColor,
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: ThemeConstant.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: ThemeConstant.cardBorderRadius,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        minimumSize: const Size(48, 48),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
  );
}
