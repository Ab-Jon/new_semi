import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// SEMIBILL tokens taken from the Figma frames (node 348-8175).
class SemiColors {
  static const brand = Color(0xFF2B124C);
  static const brandBright = Color(0xFF632AAE);
  static const accent = Color(0xFF6C3EFF);
  static const lavender = Color(0xFFDFD7F3);
  static const lavenderSoft = Color(0xFFF3EDFF);
  static const iconWash = Color(0xFFF3EDFF);
  static const iconTint = Color(0xFF9B87C4);
  static const navBar = Color(0xFF2B124C);
  static const navBarDark = Color(0xFF141414);
  static const navSelected = Color(0xFFE8DFF5);
  static const bgLight = Color(0xFFFFFFFF);
  static const bgDark = Color(0xFF0B0B0B);
  static const cardDark = Color(0xFF161616);
  static const surfaceDark = Color(0xFF1C1C1C);
  static const mutedLight = Color(0xFF6B7280);
  static const mutedDark = Color(0xFF9CA3AF);
  static const success = Color(0xFF16A34A);
  static const danger = Color(0xFFE11D48);
  static const phoneChrome = Color(0xFF1A1228);
  static const dividerLight = Color(0xFFF0EEF4);
}

class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color background;
  final Color textPrimary;
  final Color card;
  final Color muted;
  final Color accentFill;

  AppColors({
    required this.primary,
    required this.background,
    required this.textPrimary,
    required this.card,
    required this.muted,
    required this.accentFill,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? background,
    Color? textPrimary,
    Color? card,
    Color? muted,
    Color? accentFill,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      textPrimary: textPrimary ?? this.textPrimary,
      card: card ?? this.card,
      muted: muted ?? this.muted,
      accentFill: accentFill ?? this.accentFill,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      card: Color.lerp(card, other.card, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      accentFill: Color.lerp(accentFill, other.accentFill, t)!,
    );
  }
}

extension SemiThemeX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  AppColors get semi => Theme.of(this).extension<AppColors>()!;
  Color get brand => isDark ? SemiColors.brandBright : SemiColors.brand;
  Color get pageBg => isDark ? SemiColors.bgDark : SemiColors.bgLight;
  Color get cardColor => isDark ? SemiColors.cardDark : Colors.white;
  Color get iconWash => isDark ? const Color(0xFF2A1A44) : SemiColors.iconWash;
  Color get iconTint => isDark ? SemiColors.brandBright : SemiColors.iconTint;
  Color get hairline => isDark
      ? Colors.white.withValues(alpha: 0.06)
      : SemiColors.dividerLight;
}

class SemiAppTheme {
  static ThemeData light() => _build(
        brightness: Brightness.light,
        primary: SemiColors.brand,
        background: SemiColors.bgLight,
        surface: Colors.white,
        text: const Color(0xFF111111),
        muted: SemiColors.mutedLight,
        card: Colors.white,
        fill: const Color(0xFFF6F4FA),
        accentFill: SemiColors.lavenderSoft,
      );

  static ThemeData dark() => _build(
        brightness: Brightness.dark,
        primary: SemiColors.brandBright,
        background: SemiColors.bgDark,
        surface: SemiColors.cardDark,
        text: Colors.white,
        muted: SemiColors.mutedDark,
        card: SemiColors.cardDark,
        fill: SemiColors.surfaceDark,
        accentFill: const Color(0xFF2A1A44),
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color primary,
    required Color background,
    required Color surface,
    required Color text,
    required Color muted,
    required Color card,
    required Color fill,
    required Color accentFill,
  }) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: brightness,
        primary: primary,
        surface: surface,
      ),
    );

    final textTheme = GoogleFonts.interTextTheme(base.textTheme).apply(
      bodyColor: text,
      displayColor: text,
    );

    return base.copyWith(
      scaffoldBackgroundColor: background,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: background,
        foregroundColor: text,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dividerColor: muted.withValues(alpha: 0.2),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: fill,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primary, width: 1.2),
        ),
        labelStyle: TextStyle(color: muted, fontSize: 14),
        hintStyle: TextStyle(color: muted, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          minimumSize: const Size.fromHeight(52),
          side: BorderSide(color: primary.withValues(alpha: 0.3)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? Colors.white : muted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? primary : muted.withValues(alpha: 0.3),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      extensions: [
        AppColors(
          primary: primary,
          background: background,
          textPrimary: text,
          card: card,
          muted: muted,
          accentFill: accentFill,
        ),
      ],
    );
  }
}
