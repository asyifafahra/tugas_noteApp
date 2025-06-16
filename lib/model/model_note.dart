class ModelNote {
  int? id;
  String title;
  String content;
  String date;

  ModelNote({this.id, required this.title, required this.content, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
    };
  }

  factory ModelNote.fromMap(Map<String, dynamic> map) {
    return ModelNote(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
    );
  }
}
