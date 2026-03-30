import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<List<dynamic>> getNotes() async {
    final res = await dio.get("/notes/list_items");
    return res.data;
  }

  Future<Map<String, dynamic>> getNote(int id) async {
    final res = await dio.get("/notes/$id");
    return res.data;
  }

  Future<void> createNote(Map<String, dynamic> body) async {
    await dio.post("/notes", data: body);
  }

  Future<void> deleteNote(int id) async {
    await dio.delete("/notes/$id");
  }
  Future<Response> filterNotes(String category) {
    return dio.get("/notes/filter/$category");
  }

  Future<Response> getCategories() {
    return dio.get("/notes/categories");
  }
}