import 'package:farahoush/core/config/assets/colors.dart';
import 'package:farahoush/core/styles/extentions.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeColors get themeColors => const ThemeColors(
    brightness: Brightness.dark,
    primary: AppColors.primaryColor,
    onPrimary: AppColors.onSurfaceDarkColor,
    secondary: Color(0xFF8859FF),
    onSecondary: Color(0XFFFFFFFF),
    background: AppColors.scaffoldColor,
    onBackground: AppColors.onSurfaceDarkColor,
    surface: AppColors.surfaceDarkColor,
    onSurface: AppColors.onSurfaceDarkColor,
    surfaceVariant: AppColors.lightTealColor,
    success: AppColors.successDarkColor,
    onSuccess: AppColors.onSurfaceDarkColor,
    error: AppColors.errorDarkColor,
    onError: AppColors.onSurfaceDarkColor,
    defaultText: AppColors.primaryColor,
  );

  static ThemeData get customTheme {
    return ThemeData(
      brightness: themeColors.brightness,
      colorScheme: ColorScheme(
        brightness: themeColors.brightness,
        primary: themeColors.primary,
        onPrimary: themeColors.onPrimary,
        secondary: themeColors.secondary,
        onSecondary: themeColors.onSecondary,
        error: themeColors.error,
        onError: themeColors.onError,
        surface: themeColors.surface,
        onSurface: themeColors.onSurface,
        surfaceContainerHighest: themeColors.surfaceVariant,
      ),
      scaffoldBackgroundColor: themeColors.background,
      textTheme: AppTextTheme.textTheme,
      fontFamily: 'IranYekan',
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
      ),
      extensions: <ThemeExtension>[themeColors],
      
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}

class AppTextTheme {
  const AppTextTheme._();

  static TextTheme textTheme = TextTheme(
    displayLarge: displayLarge.copyWith(
      color: AppTheme.themeColors.defaultText,
    ),
    displayMedium: displayMedium.copyWith(
      color: AppTheme.themeColors.defaultText,
    ),
    displaySmall: displaySmall.copyWith(
      color: AppTheme.themeColors.defaultText,
    ),
    headlineLarge: headlineLarge.copyWith(
      color: AppTheme.themeColors.defaultText,
    ),
    headlineMedium: headlineMedium.copyWith(
      color: AppTheme.themeColors.defaultText,
    ),
    headlineSmall: headlineSmall.copyWith(
      color: AppTheme.themeColors.defaultText,
    ),
    titleLarge: titleLarge.copyWith(color: AppTheme.themeColors.defaultText),
    titleMedium: titleMedium.copyWith(color: AppTheme.themeColors.defaultText),
    titleSmall: titleSmall.copyWith(color: AppTheme.themeColors.defaultText),
    bodyLarge: bodyLarge.copyWith(color: AppTheme.themeColors.defaultText),
    bodyMedium: bodyMedium.copyWith(color: AppTheme.themeColors.defaultText),
    bodySmall: bodySmall.copyWith(color: AppTheme.themeColors.defaultText),
    labelLarge: labelLarge.copyWith(color: AppTheme.themeColors.defaultText),
    labelMedium: labelMedium.copyWith(color: AppTheme.themeColors.defaultText),
    labelSmall: labelSmall.copyWith(color: AppTheme.themeColors.defaultText),
  );

  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle labelSmall = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );
}

extension AppTextThemeX on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
