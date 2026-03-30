import 'package:flutter/material.dart';
import 'package:json_serializer/json_serializer.dart';
import 'package:notes_app_flutter/screens/HomeScreen.dart';

import 'models/Note.dart';

void main() {
  JsonSerializer.options = JsonSerializerOptions(
    types: [UserType<Note>(Note.new)],
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      title: 'Notes App',
      routes: {"/": (_) => HomeScreen()},
    );
  }
}
