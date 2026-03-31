// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  message: json['message'] as String,
  isPinned: json['is_pinned'] as bool,
  category: json['category'] as String,
  reminderAt: json['reminder_at'] as String?,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'message': instance.message,
  'is_pinned': instance.isPinned,
  'category': instance.category,
  'reminder_at': instance.reminderAt,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
