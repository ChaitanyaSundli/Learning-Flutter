import 'package:json_annotation/json_annotation.dart';
part 'CreateNoteRequest.g.dart';

@JsonSerializable()
class CreateNoteRequest {
  final String? title;
  final String? message;

  @JsonKey(name: "is_pinned")
  final bool? isPinned;

  final String? category;
  @JsonKey(name: "reminder_at")
  final String? reminderAt;

  CreateNoteRequest({
    required this.title,
    required this.message,
    required this.isPinned,
    required this.category,
    this.reminderAt,
  });

  factory CreateNoteRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateNoteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNoteRequestToJson(this);
}
