import 'package:flutter/material.dart';
import 'notesModel.dart';
import 'package:provider/provider.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteModel>(
      builder: (context, model, child) {
        if (model.notes.isEmpty) {
          return Center(
            child: Text('Нет заметок'),
          );
        }

        return ListView.builder(
          itemCount: model.notes.length,
          itemBuilder: (context, index) {
            var note = model.notes[index];
            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  model.deleteNote(note.id);
                },
              ),
            );
          },
        );
      },
    );
  }
}
