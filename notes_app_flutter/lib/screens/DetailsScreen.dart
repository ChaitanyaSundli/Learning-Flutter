import 'package:flutter/material.dart';
import '../services/ApiClient.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final api = ApiClient.api;

  Map<String, dynamic>? note;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNote();
  }

  Future<void> loadNote() async {
    final data = await api.getNote(widget.id);
    setState(() {
      note = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Details"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await api.deleteNote(widget.id);
              Navigator.pop(context, true); 
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note?["title"] ?? "No Title",
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              if (note?["category"] != null)
                Text(
                  "Category: ${note!["category"]}",
                  style: theme.textTheme.bodyMedium,
                ),
              const SizedBox(height: 16),
              Text(
                note?["content"] ?? "",
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}