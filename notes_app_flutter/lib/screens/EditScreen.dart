import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/notes_cubit.dart';
import '../models/CreateNoteRequest.dart';
import '../services/ApiClient.dart';

class EditScreen extends StatefulWidget {
  final int id;

  const EditScreen({super.key, required this.id});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  DateTime? reminderDate;
  bool isPinned = false;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchNoteData();
  }

  Future<void> _fetchNoteData() async {
    try {
      final note = await ApiClient.api.getNote(widget.id);
      titleController.text = note.title;
      messageController.text = note.message;
      categoryController.text = note.category;

      setState(() {
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
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "Title",
                    ),
                    validator: (value) => value!.isEmpty ? "Enter title" : null,
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: categoryController,
                    style: const TextStyle(color: Colors.white),
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
                    onChanged: (bool value) {
                      setState(() => isPinned = value);
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: messageController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: "Message",
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter message" : null,
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
                      IconButton(
                        icon: const Icon(
                          Icons.calendar_today,
                        ),
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: reminderDate ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null)
                            setState(() => reminderDate = picked);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final updateNote = CreateNoteRequest(
                            title: titleController.text,
                            message: messageController.text,
                            isPinned: isPinned,
                            category: categoryController.text,
                            reminderAt: reminderDate?.toIso8601String(),
                          );

                          await context.read<NotesCubit>().updateNote(
                            widget.id,
                            updateNote,
                          );
                          if (mounted) context.pop(true);
                        }
                      },
                      child: Text(
                        "Update Note",
                        style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
