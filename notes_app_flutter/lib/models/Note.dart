import 'package:json_annotation/json_annotation.dart';

part 'Note.g.dart';

@JsonSerializable()
class Note {
  final int id;
  final String title;
  final String message;

  @JsonKey(name: "is_pinned")
  final bool isPinned;

  final String category;

  @JsonKey(name: "reminder_at")
  final String? reminderAt;

  @JsonKey(name: "created_at")
  final String createdAt;

  @JsonKey(name: "updated_at")
  final String updatedAt;

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

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
