import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/notes_cubit.dart';
import '../models/CreateNoteRequest.dart';

class CreateScreen extends StatefulWidget {
  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final titleController = TextEditingController();
  final messageController = TextEditingController();
  final categoryController = TextEditingController();
  bool isPinned = false;
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  void _saveNote() async {
    final cubit = context.read<NotesCubit>();
    final note = CreateNoteRequest(
      title: titleController.text,
      message: messageController.text,
      isPinned: isPinned,
      category: categoryController.text,
      reminderAt: selectedDate?.toIso8601String(),
    );
    await cubit.createNote(note);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Note")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: "Category"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: messageController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Message",
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: isPinned,
                    onChanged: (val) => setState(() => isPinned = val ?? false),
                  ),
                  const Text("Pin Note"),
                  const Spacer(),
                  OutlinedButton.icon(
                    onPressed: _selectDate,
                    icon: const Icon(Icons.calendar_month),
                    label: Text(
                      selectedDate != null
                          ? "${selectedDate!.toLocal()}".split(' ')[0]
                          : "Add Reminder",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveNote,
                  child: const Text("Save Note"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
