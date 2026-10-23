import 'package:flutter/material.dart';

import '../models/note.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, required this.onTap});

  final Note note;
  final VoidCallback onTap;

  static const _noteIcons = <String, IconData>{
    'Ide Aplikasi': Icons.lightbulb_outline_rounded,
    'Rencana Mingguan': Icons.calendar_today_outlined,
    'Catatan Kuliah': Icons.menu_book_outlined,
    'Hal yang Perlu Dibeli': Icons.shopping_cart_outlined,
    'Jurnal Harian': Icons.favorite_border_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final colorIndex = note.colorIndex.clamp(0, AppColors.noteFills.length - 1);
    return Material(
      color: AppColors.noteFills[colorIndex],
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _noteIcons[note.title] ?? Icons.notes_rounded,
                  color: AppColors.noteAccents[colorIndex],
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.subtitle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatNoteDate(note.createdAt),
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Opsi ${note.title}',
                onPressed: () => ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(content: Text('Segera hadir'))),
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: AppColors.textSecondary,
                ),
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatNoteDate(DateTime date) {
  const months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}

String formatNoteDateTime(DateTime date) {
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  return '${formatNoteDate(date)} · $hour.$minute';
}
