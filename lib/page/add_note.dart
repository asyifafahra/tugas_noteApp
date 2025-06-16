import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/model/model_note.dart';
import 'package:notes_app/helper/db_helper.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();

  void _saveNote() async {
    if (_formKey.currentState!.validate()) {
      String date = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
      final note = ModelNote(
          title: _titleCtrl.text, content: _contentCtrl.text, date: date);
      await DatabaseHelper().insertNote(note);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEF), // warna creamy background
      appBar: AppBar(
        title: const Text("Add Note", style: TextStyle(color: Colors.black)),
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
              // Title tanpa Card, hanya underline
              TextFormField(
                controller: _titleCtrl,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.grey.shade700),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Title required' : null,
              ),

              const SizedBox(height: 30),

              // Content tanpa Card, multiline dengan underline
              Expanded(
                child: TextFormField(
                  controller: _contentCtrl,
                  style: const TextStyle(fontSize: 18),
                  maxLines: null, // supaya multiline otomatis tinggi
                  decoration: InputDecoration(
                    labelText: 'Content',
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: UnderlineInputBorder(
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
                  onPressed: _saveNote,
                  icon: const Icon(Icons.save),
                  label: const Text("Save", style: TextStyle(fontSize: 18)),
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
