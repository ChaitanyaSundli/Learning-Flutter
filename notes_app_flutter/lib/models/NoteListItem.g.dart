// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NoteListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteListItem _$NoteListItemFromJson(Map<String, dynamic> json) => NoteListItem(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  isPinned: json['is_pinned'] as bool,
  category: json['category'] as String,
);

Map<String, dynamic> _$NoteListItemToJson(NoteListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'is_pinned': instance.isPinned,
      'category': instance.category,
    };
