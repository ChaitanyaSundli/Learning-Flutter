import 'package:json_annotation/json_annotation.dart';

part 'NoteListItem.g.dart';

@JsonSerializable()
class NoteListItem {
  final int id;
  final String title;

  @JsonKey(name: "is_pinned")
  final bool isPinned;

  final String category;

  NoteListItem({
    required this.id,
    required this.title,
    required this.isPinned,
    required this.category,
  });

  factory NoteListItem.fromJson(Map<String, dynamic> json) =>
      _$NoteListItemFromJson(json);

  Map<String, dynamic> toJson() => _$NoteListItemToJson(this);
}
