import 'package:flutter/material.dart';

import '../models/note.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_text_field.dart';
import '../widgets/color_picker_row.dart';
import '../widgets/primary_button.dart';
import '../widgets/priority_selector.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _category;
  int _colorIndex = 0;
  NotePriority _priority = NotePriority.medium;

  void _saveNote() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Judul catatan tidak boleh kosong')),
        );
      return;
    }

    Navigator.of(context).pop(
      Note(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title,
        content: _contentController.text.trim(),
        category: _category ?? 'Pribadi',
        colorIndex: _colorIndex,
        priority: _priority,
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Catatan', style: AppTextStyles.heading),
        leading: IconButton(
          tooltip: 'Kembali',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FieldLabel('Judul Catatan'),
              const SizedBox(height: 8),
              AppTextField(
                controller: _titleController,
                hint: 'Masukkan judul catatan',
                icon: Icons.title_rounded,
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              const _FieldLabel('Isi Catatan'),
              const SizedBox(height: 8),
              AppTextField(
                controller: _contentController,
                hint: 'Tulis catatan Anda di sini…',
                icon: Icons.notes_rounded,
                minLines: 5,
                maxLines: 8,
              ),
              const SizedBox(height: 20),
              const _FieldLabel('Kategori'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _category,
                hint: const Text('Pilih kategori'),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.folder_open_outlined,
                    color: AppColors.textSecondary,
                  ),
                ),
                items: const ['Penting', 'Pribadi', 'Kerja']
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _category = value),
              ),
              const SizedBox(height: 20),
              const _FieldLabel('Warna'),
              const SizedBox(height: 8),
              ColorPickerRow(
                selectedIndex: _colorIndex,
                onSelected: (index) => setState(() => _colorIndex = index),
              ),
              const SizedBox(height: 20),
              const _FieldLabel('Prioritas'),
              const SizedBox(height: 8),
              PrioritySelector(
                value: _priority,
                onChanged: (priority) => setState(() => _priority = priority),
              ),
              const SizedBox(height: 28),
              PrimaryButton(label: 'Simpan', onPressed: _saveNote),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.subtitle.copyWith(color: AppColors.textPrimary),
    );
  }
}
