import '../models/note.dart';

final List<Note> dummyNotes = [
  Note(
    id: 'idea-app',
    title: 'Ide Aplikasi',
    content:
        'Ide untuk membuat aplikasi catatan sederhana dengan fitur kategori, '
        'warna, dan prioritas. Aplikasi ini digunakan untuk mencatat ide, '
        'rencana, dan hal penting sehari-hari.',
    category: 'Penting',
    colorIndex: 2,
    priority: NotePriority.high,
    createdAt: DateTime(2026, 10, 19, 9, 30),
  ),
  Note(
    id: 'weekly-plan',
    title: 'Rencana Mingguan',
    content:
        'Menyelesaikan tugas kuliah, merapikan meja belajar, dan meluangkan '
        'waktu untuk berolahraga minggu ini.',
    category: 'Kerja',
    colorIndex: 1,
    priority: NotePriority.medium,
    createdAt: DateTime(2026, 10, 18, 14, 0),
  ),
  Note(
    id: 'lecture-notes',
    title: 'Catatan Kuliah',
    content:
        'Ringkasan materi pertemuan hari ini: pahami konsep dasar terlebih '
        'dahulu, lalu kerjakan latihan untuk memperkuat pemahaman.',
    category: 'Pribadi',
    colorIndex: 4,
    priority: NotePriority.medium,
    createdAt: DateTime(2026, 10, 17, 10, 15),
  ),
  Note(
    id: 'shopping-list',
    title: 'Hal yang Perlu Dibeli',
    content: 'Buku catatan, pulpen hitam, susu, dan buah untuk persediaan.',
    category: 'Pribadi',
    colorIndex: 3,
    priority: NotePriority.low,
    createdAt: DateTime(2026, 10, 16, 16, 45),
  ),
  Note(
    id: 'daily-journal',
    title: 'Jurnal Harian',
    content:
        'Hari yang cukup produktif. Senang bisa menyelesaikan beberapa hal '
        'yang sudah direncanakan sejak pagi.',
    category: 'Pribadi',
    colorIndex: 0,
    priority: NotePriority.low,
    createdAt: DateTime(2026, 10, 15, 20, 0),
  ),
];
