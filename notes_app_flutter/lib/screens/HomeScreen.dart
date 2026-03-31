import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/notes_cubit.dart';
import '../cubit/notes_state.dart';
import 'CreateScreen.dart';
import 'DetailScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  HomeScreenView();
  }
}

class HomeScreenView extends StatefulWidget {
  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  String selectedCategory = "All";
  List<String> categories = ["All"];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() async {
    final cubit = context.read<NotesCubit>();
    final cats = await cubit.getCategories();
    setState(() => categories = cats);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotesCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Notes")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreateScreen()),
          );
          if (created == true) {
            cubit.loadNotes();
          }
        },
        label: const Text("Create Note"),
        icon: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final cat = categories[i];
                final selected = selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (_) {
                      setState(() => selectedCategory = cat);
                      cubit.filterNotes(cat);
                    },
                  ),
                );
              },
            ),
          ),
          
          Expanded(
            child: BlocBuilder<NotesCubit, NotesState>(
              builder: (_, state) {
                if (state is NotesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NotesError) {
                  return Center(child: Text(state.message));
                } else if (state is NotesLoaded) {
                  if (state.notes.isEmpty) return const Center(child: Text("No notes found"));
                  return ListView.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (_, index) {
                      final note = state.notes[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(note.category, style: TextStyle(color: Colors.grey[600])),
                            ),
                            trailing: note.isPinned ? const Icon(Icons.push_pin, color: Colors.orange) : null,
                            onTap: () async {
                              final deleted = await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => DetailScreen(id: note.id)),
                              );
                              if (deleted == true) {
                                cubit.loadNotes(); 
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          )
        ],
      ),
    );
  }
}