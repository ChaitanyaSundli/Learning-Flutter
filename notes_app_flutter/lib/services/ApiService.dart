import 'package:dio/dio.dart';
import 'package:notes_app_flutter/models/CreateNoteRequest.dart';
import 'package:notes_app_flutter/models/NoteListItem.dart';
import 'package:retrofit/retrofit.dart';

import '../models/Note.dart';

part 'ApiService.g.dart';

@RestApi(baseUrl: "http://172.30.1.152:3000")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/notes/list_items")
  Future<List<NoteListItem>> getNotes();

  @GET("/notes/{id}")
  Future<Note> getNote(@Path("id") int id);

  @POST("/notes")
  Future<void> createNote(@Body() CreateNoteRequest body);

  @DELETE("/notes/{id}")
  Future<void> deleteNote(@Path("id") int id);

  @GET("/notes/filter/{category}")
  Future<List<NoteListItem>> filterNotes(@Path("category") String category);

  @GET("/notes/categories")
  Future<List<String>> getCategories();

  @PATCH("/notes/{id}")
  Future<void> updateNote(@Path("id") int id, @Body() CreateNoteRequest body);
}
