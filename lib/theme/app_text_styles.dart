import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const display = TextStyle(
    fontSize: 28,
    height: 34 / 28,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
  );

  static const title = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const heading = TextStyle(
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const subtitle = TextStyle(
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontSize: 14,
    height: 22 / 14,
    color: AppColors.textPrimary,
  );

  static const caption = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const button = TextStyle(
    fontSize: 15,
    height: 20 / 15,
    fontWeight: FontWeight.w700,
  );
}
