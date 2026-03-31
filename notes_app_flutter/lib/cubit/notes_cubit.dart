import 'package:bloc/bloc.dart';
import '../services/ApiService.dart';
import '../services/ApiClient.dart';
import '../models/CreateNoteRequest.dart';
import 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final ApiService api = ApiClient.api;

  NotesCubit() : super(NotesInitial());

  Future<void> loadNotes() async {
    try {
      emit(NotesLoading());
      final notes = await api.getNotes();
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> filterNotes(String category) async {
    try {
      emit(NotesLoading());
      final notes =
      category == "All" ? await api.getNotes() : await api.filterNotes(category);
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      await api.deleteNote(id);
      await loadNotes();
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> createNote(CreateNoteRequest note) async {
    try {
      await api.createNote(note);
      await loadNotes();
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<List<String>> getCategories() async {
    final cats = await api.getCategories();
    return ["All", ...cats];
  }

  Future<void> updateNote(int id, CreateNoteRequest updateNote) async {
    try {
      await api.updateNote(id, updateNote);
      await loadNotes();
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

}