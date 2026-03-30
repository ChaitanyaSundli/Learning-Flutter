class CreateNoteRequest {
  String title;
  String message;
  bool isPinned;
  String category;
  String? reminderAt;

  CreateNoteRequest({
    required this.title,
    required this.message,
    required this.isPinned,
    required this.category,
    this.reminderAt,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "is_pinned": isPinned,
    "category": category,
    "reminder_at": reminderAt,
  };
}