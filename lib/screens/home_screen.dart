import 'package:flutter/material.dart';

import '../data/dummy_notes.dart';
import '../models/note.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/category_chip.dart';
import '../widgets/note_card.dart';
import 'add_note_screen.dart';
import 'note_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _categories = ['Semua', 'Penting', 'Pribadi', 'Kerja'];
  final _searchController = TextEditingController();
  final List<Note> _notes = List.of(dummyNotes);
  String _selectedCategory = 'Semua';
  String _query = '';

  List<Note> get _filteredNotes {
    final normalizedQuery = _query.trim().toLowerCase();
    return _notes.where((note) {
      final matchesCategory =
          _selectedCategory == 'Semua' || note.category == _selectedCategory;
      final matchesQuery = note.title.toLowerCase().contains(normalizedQuery);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  Future<void> _addNote() async {
    final note = await Navigator.of(context).push<Note>(
      MaterialPageRoute<Note>(builder: (_) => const AddNoteScreen()),
    );
    if (!mounted || note == null) return;
    setState(() => _notes.insert(0, note));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Catatan disimpan')));
  }

  Future<void> _openNote(Note note) async {
    final deleted = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(builder: (_) => NoteDetailScreen(note: note)),
    );
    if (deleted == true && mounted) {
      setState(() => _notes.removeWhere((item) => item.id == note.id));
    }
  }

  void _showFilterOptions() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Filter kategori', style: AppTextStyles.heading),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories
                    .map(
                      (category) => CategoryChip(
                        label: category,
                        selected: category == _selectedCategory,
                        onTap: () {
                          setState(() => _selectedCategory = category);
                          Navigator.pop(context);
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoon() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Segera hadir')));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notes = _filteredNotes;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Halo, Ivan Mahendra', style: AppTextStyles.title),
                          const SizedBox(height: 4),
                          const Text(
                            'Apa yang ingin kamu catat hari ini?',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    Semantics(
                      label: 'Profil pengguna',
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.primarySoft,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) => setState(() => _query = value),
                          style: AppTextStyles.body,
                          decoration: InputDecoration(
                            hintText: 'Cari catatan…',
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: AppColors.textSecondary,
                            ),
                            filled: true,
                            fillColor: AppColors.primarySoft,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: Tooltip(
                        message: 'Filter kategori',
                        child: InkWell(
                          onTap: _showFilterOptions,
                          borderRadius: BorderRadius.circular(12),
                          child: Center(
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                border: Border.all(color: AppColors.outline),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.tune_rounded,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 48,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return CategoryChip(
                      label: category,
                      selected: _selectedCategory == category,
                      onTap: () => setState(() => _selectedCategory = category),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: notes.isEmpty
                    ? const _EmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 96),
                        itemCount: notes.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: NoteCard(
                            note: notes[index],
                            onTap: () => _openNote(notes[index]),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: 'Tambah catatan',
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        elevation: 5,
        child: const Icon(Icons.add_rounded, size: 28),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 64,
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.outline)),
          ),
          child: Row(
            children: [
              _NavigationItem(
                icon: Icons.home_outlined,
                label: 'Beranda',
                selected: true,
                onTap: () {},
              ),
              _NavigationItem(
                icon: Icons.archive_outlined,
                label: 'Arsip',
                onTap: _showComingSoon,
              ),
              _NavigationItem(
                icon: Icons.person_outline_rounded,
                label: 'Profil',
                onTap: _showComingSoon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textSecondary;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 2),
              Text(label, style: AppTextStyles.caption.copyWith(color: color)),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.menu_book_outlined,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 12),
            Text(
              'Belum ada catatan di kategori ini.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
