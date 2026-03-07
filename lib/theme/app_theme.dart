import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Modern Black/Blue/White Color Scheme
  static const background = Color(0xFFFFFFFF); // Pure white
  static const foreground = Color(0xFF1A1A1A); // Dark charcoal
  static const primary = Color(0xFF2563EB); // Modern blue
  static const primaryForeground = Colors.white;
  static const secondary = Color(0xFF1E293B); // Dark slate
  static const secondaryForeground = Colors.white;
  static const accent = Color(0xFF3B82F6); // Lighter blue accent
  static const muted = Color(0xFFF8FAFC); // Light gray
  static const mutedForeground = Color(0xFF64748B); // Medium gray
  static const card = Color(0xFFFFFFFF); // White cards
  static const input = Color(0xFFF1F5F9); // Light input background
  static const border = Color(0xFFE2E8F0); // Light border
  static const destructive = Color(0xFFEF4444); // Red for errors
  static const success = Color(0xFF10B981); // Green for success
  static const warning = Color(0xFFF59E0B); // Amber for warnings

  // Additional modern colors
  static const surface = Color(0xFFF8FAFC); // Light surface
  static const onSurface = Color(0xFF334155); // Text on surface
}

class AppTheme {
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.card,
          error: AppColors.destructive,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
      );
}