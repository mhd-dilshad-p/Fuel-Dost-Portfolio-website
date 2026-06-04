import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1B7A3E); // Deep Green
  static const Color accent = Color(0xFFF97316);  // Orange
  static const Color background = Color(0xFFFAFAFA); // White Theme Light Gray-White
  static const Color cardBackground = Colors.white; // Pure White
  static const Color textPrimary = Color(0xFF111827); // Dark slate/almost black
  static const Color textSecondary = Color(0xFF4B5563); // Slate gray
  static const Color divider = Color(0xFFE5E7EB); // Light gray
  
  // Custom Gradients
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1B7A3E), Color(0xFF115E30)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient backgroundGradient = LinearGradient(
    colors: [Color(0xFFFAFAFA), Color(0xFFF3F4F6)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient greenAccentGradient = LinearGradient(
    colors: [Color(0xFF1B7A3E), Color(0xFFF97316)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
