import 'package:dio/dio.dart';

import 'ApiService.dart';

class ApiClient {
  static final dio = Dio(
    BaseOptions(
      headers: {"Content-Type": "application/json",
        "Accept": "application/json"},
      connectTimeout: Duration(minutes: 2),
    ),
  );

  static final api = ApiService(dio);
}
