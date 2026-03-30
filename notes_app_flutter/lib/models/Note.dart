class Note {
  int id;
  String title;
  String message;
  bool isPinned;
  String category;
  String? reminderAt;
  String createdAt;
  String updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.message,
    required this.isPinned,
    required this.category,
    this.reminderAt,
    required this.createdAt,
    required this.updatedAt,
  });
}