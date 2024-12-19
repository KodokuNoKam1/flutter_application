import 'package:flutter/material.dart';
import 'notesModel.dart';
import 'package:provider/provider.dart';

class NotesEntry extends StatefulWidget {
  const NotesEntry({super.key});

  @override
  _NotesEntryState createState() => _NotesEntryState();
}

class _NotesEntryState extends State<NotesEntry> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _content;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Заголовок'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите заголовок';
              }
              return null;
            },
            onSaved: (value) {
              _title = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Содержание'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите содержание';
              }
              return null;
            },
            onSaved: (value) {
              _content = value;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                if (_title != null && _content != null) {
                  Provider.of<NoteModel>(context, listen: false).addNote(Note(
                    id: DateTime.now().millisecondsSinceEpoch,
                    title: _title!,
                    content: _content!,
                  ));
                }
              }
            },
            child: Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
