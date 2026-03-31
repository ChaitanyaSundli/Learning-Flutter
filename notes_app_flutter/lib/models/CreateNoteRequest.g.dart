// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CreateNoteRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNoteRequest _$CreateNoteRequestFromJson(Map<String, dynamic> json) =>
    CreateNoteRequest(
      title: json['title'] as String?,
      message: json['message'] as String?,
      isPinned: json['is_pinned'] as bool?,
      category: json['category'] as String?,
      reminderAt: json['reminder_at'] as String?,
    );

Map<String, dynamic> _$CreateNoteRequestToJson(CreateNoteRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'message': instance.message,
      'is_pinned': instance.isPinned,
      'category': instance.category,
      'reminder_at': instance.reminderAt,
    };
