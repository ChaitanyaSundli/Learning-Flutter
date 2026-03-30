import 'package:dio/dio.dart';
import 'ApiService.dart';

class ApiClient {
  static final dio = Dio(
    BaseOptions(
      baseUrl: "http://172.30.1.152:3000",
      headers: {"Content-Type": "application/json"},
    ),
  );

  static final api = ApiService(dio);
}