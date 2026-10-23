import 'package:flutter/material.dart';

import '../models/note.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class PrioritySelector extends StatelessWidget {
  const PrioritySelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final NotePriority value;
  final ValueChanged<NotePriority> onChanged;

  static const _options = [
    (NotePriority.low, 'Rendah'),
    (NotePriority.medium, 'Sedang'),
    (NotePriority.high, 'Tinggi'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: _options.map((option) {
          final (priority, label) = option;
          final selected = value == priority;
          return Expanded(
            child: Semantics(
              button: true,
              selected: selected,
              child: InkWell(
                onTap: () => onChanged(priority),
                borderRadius: BorderRadius.circular(10),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 48,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: AppTextStyles.caption.copyWith(
                        color: selected
                            ? AppColors.surface
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
