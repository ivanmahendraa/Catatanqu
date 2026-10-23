import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ColorPickerRow extends StatelessWidget {
  const ColorPickerRow({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      children: List.generate(AppColors.noteAccents.length, (index) {
        final selected = index == selectedIndex;
        return Semantics(
          button: true,
          selected: selected,
          label: 'Warna catatan ${_colorNames[index]}',
          child: InkWell(
            onTap: () => onSelected(index),
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: 48,
              height: 48,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.noteAccents[index],
                    shape: BoxShape.circle,
                    border: selected
                        ? Border.all(color: AppColors.textPrimary, width: 2)
                        : null,
                  ),
                  child: selected
                      ? const Icon(
                          Icons.check_rounded,
                          color: AppColors.surface,
                          size: 20,
                        )
                      : null,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

const _colorNames = ['biru', 'mint', 'kuning', 'merah muda', 'ungu'];
