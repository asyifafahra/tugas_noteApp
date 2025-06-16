import 'package:flutter/material.dart';
import 'package:notes_app/helper/db_helper.dart';
import 'package:notes_app/model/model_note.dart';
import 'package:notes_app/page/add_note.dart';
import 'package:notes_app/page/detail_note_page.dart';
import 'package:notes_app/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = DatabaseHelper();
  final TextEditingController _searchCtrl = TextEditingController();
  List<ModelNote> _notes = [];
  List<ModelNote> _filteredNotes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
    _searchCtrl.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _loadNotes() async {
    final notes = await db.getNotes();
    setState(() {
      _notes = notes;
      _filteredNotes = notes;
    });
  }

  void _refreshNotes() {
    _loadNotes();
  }

  void _navigateToAddNote() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNotePage()),
    );
    _refreshNotes();
  }

  void _navigateToDetailNote(ModelNote note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailNotePage(note: note)),
    );
    _refreshNotes();
  }

  void _onSearchChanged() {
    final query = _searchCtrl.text.toLowerCase();
    setState(() {
      _filteredNotes = _notes.where((note) {
        return note.title.toLowerCase().contains(query) ||
            note.content.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.note_alt, color: Color.fromARGB(255, 234, 213, 153), size: 30),
            SizedBox(width: 8),
            Text(
              "My Notes",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: 50,
              child: TextField(
                controller: _searchCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade800),
                  hintText: 'Search anything',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            // Note grid
            Expanded(
              child: _filteredNotes.isEmpty
                  ? const Center(child: Text("No notes found."))
                  : GridView.builder(
                      itemCount: _filteredNotes.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final note = _filteredNotes[index];
                        final color = getNoteColor(note.id!);

                        return GestureDetector(
                          onTap: () => _navigateToDetailNote(note),
                          child: Container(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                )
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Tanpa Hero
                                Text(
                                  note.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: Text(
                                    note.content,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  note.date,
                                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddNote,
        backgroundColor: const Color.fromARGB(255, 234, 213, 153),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
