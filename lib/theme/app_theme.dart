import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xFFFBFCFE);
  static const foreground = Color(0xFF0B1220);
  static const primary = Color(0xFF0066CC);
  static const primaryForeground = Colors.white;
  static const secondary = Color(0xFFE6F0FF);
  static const secondaryForeground = Color(0xFF05466E);
  static const accent = Color(0xFFFF8A00);
  static const muted = Color(0xFFF0F2F4);
  static const mutedForeground = Color(0xFF73808A);
  static const card = Colors.white;
  static const input = Color(0xFFF3F6FB);
  static const border = Color(0x14000000);
  static const destructive = Color(0xFFE03E3E);
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFFFB020);
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