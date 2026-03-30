import 'package:json_serializer/json_serializer.dart';
import 'package:notes_app_flutter/models/Note.dart';

void setupSerializer() {
  JsonSerializer.options = JsonSerializerOptions(
    types: [
      UserType<Note>(Note.new),
    ],
  );
}