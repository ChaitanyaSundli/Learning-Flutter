import '../models/NoteListItem.dart';

abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<NoteListItem> notes;
  NotesLoaded(this.notes);
}

class NotesError extends NotesState {
  final String message;
  NotesError(this.message);
}
