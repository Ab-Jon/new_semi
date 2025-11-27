import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color accent; // primary accent used across app (buttons, icons)
  final Color accentContainer; // used for small highlight backgrounds (chips)
  final Color danger; // red for the "Say No to ..." dots

  const AppColors({
    required this.accent,
    required this.accentContainer,
    required this.danger,
  });

  @override
  AppColors copyWith({Color? accent, Color? accentContainer, Color? danger}) {
    return AppColors(
      accent: accent ?? this.accent,
      accentContainer: accentContainer ?? this.accentContainer,
      danger: danger ?? this.danger,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      accent: Color.lerp(accent, other.accent, t)!,
      accentContainer: Color.lerp(accentContainer, other.accentContainer, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }
}

// Factory helpers for light/dark theme extension instances:
final AppColors lightAppColors = const AppColors(
  accent: Color(0xFF2B124C),
  accentContainer: Color(0xFFEDDDFC), // subtle light purple container
  danger: Color(0xFFE23E3E),
);

final AppColors darkAppColors = const AppColors(
  accent: Color(0xFF632AAE),
  accentContainer: Color(0xFF2D1A36),
  danger: Color(0xFFE23E3E),
);

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: lightAppColors.accent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
    ),
    textTheme: Typography.blackMountainView,
    extensions: <ThemeExtension<dynamic>>[lightAppColors],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightAppColors.accent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size.fromHeight(48),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF5F5F7),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      hintStyle: TextStyle(color: Colors.grey.shade500),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkAppColors.accent,
    scaffoldBackgroundColor: const Color(0xFF0F0F11),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
    ),
    textTheme: Typography.whiteMountainView,
    extensions: <ThemeExtension<dynamic>>[darkAppColors],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkAppColors.accent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size.fromHeight(48),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1B1B1D),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      hintStyle: TextStyle(color: Colors.grey.shade400),
    ),
  );
}
