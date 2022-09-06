import 'package:flutter/material.dart';

enum Languages { english, hindi }

enum Shadows { sm, md, lg, none }

extension ShadowsExtension on Shadows {
  double get size {
    switch (this) {
      case Shadows.sm:
        return 2.0;

      case Shadows.md:
        return 5.0;

      case Shadows.lg:
        return 10.0;

      default:
        return 0.0;
    }
  }
}

enum AppColors {
  primary,
  secondary,
  warning,
  danger,
  success,
  info,
  white,
  dark
}

extension AppColorsExtension on AppColors {
  Color get color {
    switch (this) {
      case AppColors.primary:
        return Colors.blue.shade700;

      case AppColors.success:
        return Colors.green.shade700;

      case AppColors.danger:
        return Colors.red.shade700;

      case AppColors.warning:
        return Colors.amber.shade700;

      case AppColors.info:
        return Colors.cyan.shade700;

      case AppColors.white:
        return Colors.white;

      case AppColors.dark:
        return Colors.black87;

      default:
        return Colors.brown.shade100;
    }
  }
}

enum FontSizes { small, smaller, regular, larger, large, huge }

extension FontSizesExtension on FontSizes {
  double get size {
    switch (this) {
      case FontSizes.small:
        return 12;

      case FontSizes.smaller:
        return 14;

      case FontSizes.regular:
        return 16;

      case FontSizes.larger:
        return 18;

      case FontSizes.large:
        return 20;

      default:
        return 22;
    }
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
