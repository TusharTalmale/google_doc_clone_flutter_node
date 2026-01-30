import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  // =============================
  // brand colors
  // =============================

  static const Color primary = Color(0xFF1A73E8); // Google Blue
  static const Color secondary = Color(0xFF5F6368);
  // =============================
  // Background Colors
  // =============================
  
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Colors.white;

  // =============================
  // Text Colors
  // =============================

  static const Color textPrimary = Color(0xFF202124);
  static const Color textSecondary = Color(0xFF5F6368);
  static const Color textHint = Color(0xFF9AA0A6);

  // =============================
  // Borders & Dividers
  // =============================

  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // =============================
  // Status Colors
  // =============================

  static const Color success = Color(0xFF34A853);
  static const Color warning = Color(0xFFFBBC05);
  static const Color error = Color(0xFFB00020);
  static const Color info = Color(0xFF00ACC1);

  // =============================
  // Editor Presence Colors
  // =============================

  static const List<Color> cursorColors = [
    Color(0xFF1A73E8),
    Color(0xFF34A853),
    Color(0xFFFBBC05),
    Color(0xFFEA4335),
    Color(0xFF9C27B0),
    Color(0xFF00ACC1),
  ];
}
