import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/notes_cubit.dart';
import '../services/ApiClient.dart';
import 'EditScreen.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isLoading = true;
  String? _errorMessage;

  String title = "";
  String message = "";
  String category = "";
  bool isPinned = false;
  DateTime? reminderDate;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  Future<void> _loadNote() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final note = await ApiClient.api.getNote(widget.id);

      setState(() {
        title = note.title;
        message = note.message;
        category = note.category;
        isPinned = note.isPinned;
        reminderDate = note.reminderAt != null
            ? DateTime.parse(note.reminderAt!)
            : null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotesCubit>();

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await cubit.deleteNote(widget.id);
              context.pop();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final updated = await context.push<bool>('/edit/${widget.id}');

          if (updated == true) {
            cubit.loadNotes();
            _loadNote();
          }
        },
        label: const Text("Edit"),
        icon: const Icon(Icons.edit),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),

          child: SingleChildScrollView(
            child: Column(
              children: [

                TextFormField(
                  initialValue: title,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Title",
                  ),
                ),
                const SizedBox(height: 12),


                TextFormField(
                  initialValue: category,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Category",
                  ),
                ),
                const SizedBox(height: 12),


                SwitchListTile(
                  title: const Text(
                    "Pin Note",
                  ),
                  activeColor: Colors.orangeAccent,
                  value: isPinned,
                  onChanged: null,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 12),


                TextFormField(
                  initialValue: message,
                  readOnly: true,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: "Message",
                  ),
                ),
                const SizedBox(height: 16),


                Row(
                  children: [
                    Expanded(
                      child: Text(
                        reminderDate == null
                            ? "No Reminder"
                            : "Reminder: ${reminderDate!.toLocal().toString().split(' ')[0]}",
                      ),
                    ),
                    const Icon(
                      Icons.calendar_today,
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}