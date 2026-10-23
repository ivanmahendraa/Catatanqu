import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF2F6BFF);
  static const primaryDark = Color(0xFF1F4FD8);
  static const primarySoft = Color(0xFFE8F0FF);
  static const background = Color(0xFFF6F9FF);
  static const surface = Colors.white;
  static const outline = Color(0xFFD9E3F5);
  static const textPrimary = Color(0xFF14213D);
  static const textSecondary = Color(0xFF5B6B8C);
  static const danger = Color(0xFFE5484D);
  static const success = Color(0xFF2E9E6B);
  static const importantFill = Color(0xFFFCE7A8);
  static const importantText = Color(0xFF7A5A00);

  static const buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF3B7BFF), Color(0xFF2F5FF0)],
  );

  static const noteFills = [
    Color(0xFFE6EFFE),
    Color(0xFFE2F5EA),
    Color(0xFFFFF3D1),
    Color(0xFFFDE6EC),
    Color(0xFFEBE5FA),
  ];

  static const noteAccents = [
    Color(0xFF3B82F6),
    Color(0xFF2FB37A),
    Color(0xFFF5B50A),
    Color(0xFFEF5B84),
    Color(0xFF7C5CD6),
  ];
}
