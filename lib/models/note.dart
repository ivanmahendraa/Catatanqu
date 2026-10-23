enum NotePriority { low, medium, high }

class Note {
  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.colorIndex,
    required this.priority,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String content;
  final String category;
  final int colorIndex;
  final NotePriority priority;
  final DateTime createdAt;

  String get priorityLabel {
    switch (priority) {
      case NotePriority.low:
        return 'Rendah';
      case NotePriority.medium:
        return 'Sedang';
      case NotePriority.high:
        return 'Tinggi';
    }
  }
}
