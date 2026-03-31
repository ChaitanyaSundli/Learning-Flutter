import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_flutter/routing/note_routes.dart';
import 'package:notes_app_flutter/screens/HomeScreen.dart';

import 'cubit/notes_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => NotesCubit()..loadNotes(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      title: 'Notes App',
      routerConfig: router,
    );
  }
}
