import 'package:flutter/material.dart';
import 'package:notes_app/helper/db_helper.dart';
import 'package:notes_app/model/model_note.dart';
import 'package:notes_app/utils.dart';

class DetailNotePage extends StatefulWidget {
  final ModelNote note;

  const DetailNotePage({super.key, required this.note});

  @override
  State<DetailNotePage> createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  final db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() async {
    final updatedNote = ModelNote(
      id: widget.note.id,
      title: _titleController.text,
      content: _contentController.text,
      date: DateTime.now().toString().substring(0, 10), // misal update tanggal sekarang
    );

    await db.updateNote(updatedNote);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Catatan berhasil disimpan")),
    );
    Navigator.pop(context, updatedNote);
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = getNoteColor(widget.note.id!);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.black),
            onPressed: _saveNote,
            tooltip: 'Simpan',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField Judul
            TextField(
              controller: _titleController,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Judul catatan',
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.access_time_filled_rounded, size: 16, color: Colors.black),
                const SizedBox(width: 6),
                Text(
                  widget.note.date,
                  style: const TextStyle(color: Colors.black, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // TextField Konten (bisa scroll)
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Isi catatan',
                ),
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
