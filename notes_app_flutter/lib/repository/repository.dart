import 'package:notes_app_flutter/services/ApiClient.dart';

import '../models/CreateNoteRequest.dart';
import '../models/Note.dart';
import '../models/NoteListItem.dart';

class NoteRepository {
  final api = ApiClient.api;

  Future<List<NoteListItem>> getNotes() async {
    final res = await api.getNotes();

    return res.map((e) {
      return NoteListItem(
        id: e['id'],
        title: e['title'],
        isPinned: e['is_pinned'],
        category: e['category'],
      );
    }).toList();
  }

  Future<Note> getNote(int id) async {
    final e = await api.getNote(id);

    return Note(
      id: e['id'],
      title: e['title'],
      message: e['message'],
      isPinned: e['is_pinned'],
      category: e['category'],
      reminderAt: e['reminder_at'],
      createdAt: e['created_at'],
      updatedAt: e['updated_at'],
    );
  }

  Future<void> createNote(CreateNoteRequest note) async {
    await api.createNote(note.toJson());
  }

  Future<void> deleteNote(int id) async {
    await api.deleteNote(id);
  }

  Future<List<String>> getCategories() async {
    final res = await api.getCategories();
    return List<String>.from(res.data);
  }

  Future<List<NoteListItem>> filterNotes(String category) async {
    final res = await api.filterNotes(category);

    return (res.data as List).map((e) {
      return NoteListItem(
        id: e['id'],
        title: e['title'],
        isPinned: e['is_pinned'],
        category: e['category'],
      );
    }).toList();
  }
}