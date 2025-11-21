import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primary;     // your purple color
  final Color background;  // modal background
  final Color textPrimary;

  AppColors({
    required this.primary,
    required this.background,
    required this.textPrimary,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? background,
    Color? textPrimary,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      textPrimary: textPrimary ?? this.textPrimary,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
      ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
    );
  }
}
