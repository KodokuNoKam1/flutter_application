import 'package:flutter/foundation.dart';
import 'notesDBWorker.dart';

class Note {
  int id;
  String title;
  String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  Note.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        content = map['content'];
}

class NoteModel extends ChangeNotifier {
  List<Note> _notes = [];
  final NotesDBWorker _dbWorker = NotesDBWorker();

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _dbWorker.create(note).then((_) {
      _notes.add(note);
      notifyListeners();
    });
  }

  void deleteNote(int id) {
    _dbWorker.delete(id).then((_) {
      _notes.removeWhere((note) => note.id == id);
      notifyListeners();
    });
  }

  void loadNotes() async {
    _notes = await _dbWorker.getAll();
    notifyListeners();
  }
}

final noteModel = NoteModel();
