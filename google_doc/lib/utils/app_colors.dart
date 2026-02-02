import 'package:flutter/material.dart';

/// App Color Constants
/// A comprehensive color palette with glassmorphism-ready colors for both light and dark themes
class AppColors {
  AppColors._();

  // ─────────────────────────────────────────────────────────────
  // PRIMARY BRAND COLORS
  // ─────────────────────────────────────────────────────────────
  
  /// Primary brand color - vibrant blue
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF3730A3);
  
  /// Secondary brand color - sophisticated purple
  static const Color secondary = Color(0xFF7C3AED);
  static const Color secondaryLight = Color(0xFFA78BFA);
  static const Color secondaryDark = Color(0xFF5B21B6);
  
  /// Accent color - vibrant cyan
  static const Color accent = Color(0xFF06B6D4);
  static const Color accentLight = Color(0xFF22D3EE);
  static const Color accentDark = Color(0xFF0891B2);

  // ─────────────────────────────────────────────────────────────
  // LIGHT THEME COLORS
  // ─────────────────────────────────────────────────────────────
  
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF1F5F9);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFE2E8F0);
  static const Color lightBorder = Color(0xFFCBD5E1);
  
  /// Light theme text colors
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextTertiary = Color(0xFF94A3B8);
  static const Color lightTextDisabled = Color(0xFFCBD5E1);
  
  // ─────────────────────────────────────────────────────────────
  // DARK THEME COLORS
  // ─────────────────────────────────────────────────────────────
  
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkSurfaceVariant = Color(0xFF334155);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkDivider = Color(0xFF334155);
  static const Color darkBorder = Color(0xFF475569);
  
  /// Dark theme text colors
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkTextTertiary = Color(0xFF94A3B8);
  static const Color darkTextDisabled = Color(0xFF475569);

  // ─────────────────────────────────────────────────────────────
  // GLASSMORPHISM COLORS
  // ─────────────────────────────────────────────────────────────
  
  /// Light mode glass colors
  static const Color glassLight = Color(0x80FFFFFF);
  static const Color glassBorderLight = Color(0x40FFFFFF);
  static const Color glassOverlayLight = Color(0x1AFFFFFF);
  
  /// Dark mode glass colors
  static const Color glassDark = Color(0x1AFFFFFF);
  static const Color glassBorderDark = Color(0x1AFFFFFF);
  static const Color glassOverlayDark = Color(0x0DFFFFFF);
  
  /// Gradient glass backgrounds
  static const LinearGradient glassGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x40FFFFFF),
      Color(0x1AFFFFFF),
    ],
  );
  
  static const LinearGradient glassGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x1AFFFFFF),
      Color(0x0DFFFFFF),
    ],
  );

  // ─────────────────────────────────────────────────────────────
  // GRADIENT COLORS
  // ─────────────────────────────────────────────────────────────
  
  /// Primary gradient (for buttons, headers)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4F46E5),
      Color(0xFF7C3AED),
    ],
  );
  
  /// Accent gradient (for highlights)
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF06B6D4),
      Color(0xFF8B5CF6),
    ],
  );
  
  /// Background gradient for light theme
  static const LinearGradient backgroundGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF8FAFC),
      Color(0xFFE2E8F0),
    ],
  );
  
  /// Background gradient for dark theme
  static const LinearGradient backgroundGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0F172A),
      Color(0xFF1E293B),
    ],
  );
  
  /// Mesh gradient colors for dynamic backgrounds
  static const List<Color> meshGradientColors = [
    Color(0xFF4F46E5),
    Color(0xFF7C3AED),
    Color(0xFF06B6D4),
    Color(0xFFEC4899),
  ];

  // ─────────────────────────────────────────────────────────────
  // SEMANTIC COLORS
  // ─────────────────────────────────────────────────────────────
  
  /// Success colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF059669);
  
  /// Warning colors
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFFD97706);
  
  /// Error colors
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFDC2626);
  
  /// Info colors
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  static const Color infoDark = Color(0xFF2563EB);

  // ─────────────────────────────────────────────────────────────
  // COLLABORATION CURSOR COLORS
  // ─────────────────────────────────────────────────────────────
  
  static const List<Color> cursorColors = [
    Color(0xFF4F46E5), // Indigo
    Color(0xFF10B981), // Emerald
    Color(0xFFF59E0B), // Amber
    Color(0xFFEF4444), // Red
    Color(0xFF8B5CF6), // Violet
    Color(0xFF06B6D4), // Cyan
    Color(0xFFEC4899), // Pink
    Color(0xFFF97316), // Orange
  ];

  // ─────────────────────────────────────────────────────────────
  // ROLE COLORS
  // ─────────────────────────────────────────────────────────────
  
  static const Color roleOwner = Color(0xFF7C3AED);
  static const Color roleEditor = Color(0xFF4F46E5);
  static const Color roleCommenter = Color(0xFFF59E0B);
  static const Color roleViewer = Color(0xFF6B7280);

  // ─────────────────────────────────────────────────────────────
  // SHIMMER COLORS
  // ─────────────────────────────────────────────────────────────
  
  static const Color shimmerBaseLight = Color(0xFFE2E8F0);
  static const Color shimmerHighlightLight = Color(0xFFF8FAFC);
  static const Color shimmerBaseDark = Color(0xFF334155);
  static const Color shimmerHighlightDark = Color(0xFF475569);

  // ─────────────────────────────────────────────────────────────
  // HELPER METHODS
  // ─────────────────────────────────────────────────────────────
  
  /// Get text primary color based on brightness
  static Color getTextPrimary(Brightness brightness) {
    return brightness == Brightness.light ? lightTextPrimary : darkTextPrimary;
  }
  
  /// Get text secondary color based on brightness
  static Color getTextSecondary(Brightness brightness) {
    return brightness == Brightness.light ? lightTextSecondary : darkTextSecondary;
  }
  
  /// Get surface color based on brightness
  static Color getSurface(Brightness brightness) {
    return brightness == Brightness.light ? lightSurface : darkSurface;
  }
  
  /// Get background color based on brightness
  static Color getBackground(Brightness brightness) {
    return brightness == Brightness.light ? lightBackground : darkBackground;
  }
  
  /// Get glass color based on brightness
  static Color getGlass(Brightness brightness) {
    return brightness == Brightness.light ? glassLight : glassDark;
  }
  
  /// Get glass border color based on brightness
  static Color getGlassBorder(Brightness brightness) {
    return brightness == Brightness.light ? glassBorderLight : glassBorderDark;
  }
  
  /// Get divider color based on brightness
  static Color getDivider(Brightness brightness) {
    return brightness == Brightness.light ? lightDivider : darkDivider;
  }
  
  /// Get shimmer colors based on brightness
  static (Color base, Color highlight) getShimmerColors(Brightness brightness) {
    return brightness == Brightness.light
        ? (shimmerBaseLight, shimmerHighlightLight)
        : (shimmerBaseDark, shimmerHighlightDark);
  }
  
  /// Get role color
  static Color getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'owner':
        return roleOwner;
      case 'editor':
        return roleEditor;
      case 'commenter':
        return roleCommenter;
      case 'viewer':
      default:
        return roleViewer;
    }
  }
}
