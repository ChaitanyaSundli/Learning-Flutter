import 'package:flutter/material.dart';
import 'package:notes_app_flutter/screens/CreateScreen.dart';

import '../models/NoteListItem.dart';
import '../repository/repository.dart';
import 'DetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final repo = NoteRepository();

  List<NoteListItem> notes = [];
  List<String> categories = ["All"];
  String selectedCategory = "All";

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _refreshNotes();
    }
  }

  Future<void> _refreshNotes() async {
    setState(() => isLoading = true);
    final newNotes = await repo.getNotes();
    if (!mounted) return;
    setState(() {
      notes = newNotes;
      isLoading = false;
    });
  }

  Future<void> init() async {
    final cats = await repo.getCategories();
    final data = await repo.getNotes();

    setState(() {
      categories.addAll(cats);
      notes = data;
      isLoading = false;
    });
  }

  Future<void> filter(String category) async {
    setState(() {
      selectedCategory = category;
      isLoading = true;
    });

    if (category == "All") {
      notes = await repo.getNotes();
    } else {
      notes = await repo.filterNotes(category);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateScreen()),
          );
        },

        label: Text("Create Note"),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('My Notes')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (_, i) {
                        final cat = categories[i];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ChoiceChip(
                            label: Text(cat),
                            selected: selectedCategory == cat,
                            onSelected: (_) => filter(cat),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                if (notes.isEmpty)
                  const SliverFillRemaining(
                    child: Center(child: Text("No notes found")),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final note = notes[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),

                            title: Text(
                              note.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                note.category,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),

                            trailing: note.isPinned
                                ? const Icon(
                                    Icons.push_pin,
                                    color: Colors.orange,
                                  )
                                : null,

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(id: note.id),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }, childCount: notes.length),
                  ),
              ],
            ),
    );
  }
}
