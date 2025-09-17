import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Primary app colors used throughout the UI. These values have been tuned
/// for better accessibility and contrast. Darker greens provide enough
/// contrast against light backgrounds, while the background and outline
/// colors remain soft to reduce eye strain.
const Color kPrimaryGreen =
    Color(0xFF006A4E); // Main brand color (dark teal green)
const Color kPrimaryGreenDark =
    Color(0xFF004D39); // Shade for gradients and dark contexts
const Color kSurfaceWhite =
    Color(0xFFFFFFFF); // Pure white for cards and surfaces
const Color kSoftMint =
    Color(0xFFF3F8F5); // Light mint background to soften the UI
const Color kOutline = Color(0xFFB4D1C8); // Subtle outline/border color
const Color kAccentGreen =
    Color(0xFF25A67E); // Secondary accent color for chips/buttons

/// Builds the global theme for the application.
ThemeData buildAppTheme() {
  final base = ThemeData(useMaterial3: true);

  // Build an explicit color scheme to ensure all contrast pairs are defined.
  final colorScheme = ColorScheme.fromSeed(
    seedColor: kPrimaryGreen,
    brightness: Brightness.light,
    primary: kPrimaryGreen,
    onPrimary: Colors.white,
    secondary: kAccentGreen,
    onSecondary: Colors.white,
    surface: kSurfaceWhite,
  ).copyWith(
    onSurface: const Color(0xFF1F2E25),
    primaryContainer: kPrimaryGreenDark,
    onPrimaryContainer: Colors.white,
    secondaryContainer: kAccentGreen.withValues(alpha: 0.15),
    onSecondaryContainer: const Color(0xFF1F2E25),
  );

  // Create a text theme based on Inter with explicit colors for contrast. All
  // text defaults to a dark, high-contrast color defined in the color scheme.
  final textTheme = GoogleFonts.interTextTheme(base.textTheme)
      .apply(
          bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface)
      .copyWith(
        headlineLarge: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
          color: colorScheme.onSurface,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          height: 1.5,
          color: colorScheme.onSurface,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          height: 1.5,
          color: colorScheme.onSurface,
        ),
      );

  return base.copyWith(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: kSoftMint,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: kSoftMint,
      foregroundColor: colorScheme.onSurface,
      centerTitle: true,
      titleTextStyle: textTheme.titleLarge,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(12),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: kOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: kOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: kPrimaryGreen, width: 2),
      ),
      hintStyle: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6)),
      labelStyle: TextStyle(color: colorScheme.onSurface),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    chipTheme: base.chipTheme.copyWith(
      backgroundColor: kAccentGreen.withValues(alpha: 0.1),
      selectedColor: kAccentGreen.withValues(alpha: 0.3),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      shape: const StadiumBorder(side: BorderSide(color: kOutline)),
    ),
    dividerTheme: DividerThemeData(
      color: kOutline.withValues(alpha: 0.5),
      thickness: 1,
    ),
  );
}
