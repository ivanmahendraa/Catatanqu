import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 64});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppColors.buttonGradient,
        borderRadius: BorderRadius.circular(size * 0.25),
      ),
      child: Icon(
        Icons.edit_note_rounded,
        color: AppColors.surface,
        size: size * 0.58,
      ),
    );
  }
}
