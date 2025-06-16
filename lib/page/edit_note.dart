import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/model/model_note.dart';
import 'package:notes_app/helper/db_helper.dart';

class EditNotePage extends StatefulWidget {
  final ModelNote note;
  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleCtrl;
  late TextEditingController _contentCtrl;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.note.title);
    _contentCtrl = TextEditingController(text: widget.note.content);
  }

  void _updateNote() async {
    if (_formKey.currentState!.validate()) {
      String date = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
      final updatedNote = ModelNote(
        id: widget.note.id,
        title: _titleCtrl.text,
        content: _contentCtrl.text,
        date: date,
      );
      await DatabaseHelper().updateNote(updatedNote);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEF), // warna creamy
      appBar: AppBar(
        title: const Text("Edit Note", style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title dengan underline
              TextFormField(
                controller: _titleCtrl,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Title required' : null,
              ),

              const SizedBox(height: 30),

              // Content multiline
              Expanded(
                child: TextFormField(
                  controller: _contentCtrl,
                  style: const TextStyle(fontSize: 18),
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Content required' : null,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _updateNote,
                  icon: const Icon(Icons.save),
                  label: const Text("Update", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 234, 213, 153),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
