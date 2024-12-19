import 'package:flutter/material.dart';
import 'notesList.dart';
import 'notesEntry.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заметки'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: Text('Список', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            child: Text('Ввод', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: _selectedIndex == 0 ? NotesList() : NotesEntry(),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
