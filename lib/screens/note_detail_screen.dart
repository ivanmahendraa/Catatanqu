import 'package:flutter/material.dart';

import '../models/note.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/note_card.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({super.key, required this.note});

  final Note note;

  Future<void> _confirmDelete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Hapus catatan?', style: AppTextStyles.heading),
        content: const Text(
          'Catatan ini akan dihapus dan tidak bisa dikembalikan.',
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (shouldDelete == true && context.mounted) {
      Navigator.of(context).pop(true);
    }
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Segera hadir')));
  }

  @override
  Widget build(BuildContext context) {
    final colorIndex = note.colorIndex.clamp(0, AppColors.noteFills.length - 1);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Catatan', style: AppTextStyles.heading),
        leading: IconButton(
          tooltip: 'Kembali',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          IconButton(
            tooltip: 'Edit catatan',
            onPressed: () => _showComingSoon(context),
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
          ),
          IconButton(
            tooltip: 'Hapus catatan',
            onPressed: () => _confirmDelete(context),
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.danger,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.noteFills[colorIndex],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _categoryIcon(note.category),
                        color: AppColors.noteAccents[colorIndex],
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(note.title, style: AppTextStyles.heading),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              _Badge(
                                label: note.category,
                                important: note.category == 'Penting',
                              ),
                              _Badge(label: note.priorityLabel),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.textSecondary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    formatNoteDateTime(note.createdAt),
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                note.content.isEmpty ? 'Tidak ada isi catatan.' : note.content,
                style: AppTextStyles.body.copyWith(height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Penting':
        return Icons.lightbulb_outline_rounded;
      case 'Kerja':
        return Icons.calendar_today_outlined;
      case 'Pribadi':
        return Icons.menu_book_outlined;
      default:
        return Icons.notes_rounded;
    }
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, this.important = false});

  final String label;
  final bool important;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: important ? AppColors.importantFill : AppColors.surface,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: important ? AppColors.importantText : AppColors.textSecondary,
        ),
      ),
    );
  }
}
