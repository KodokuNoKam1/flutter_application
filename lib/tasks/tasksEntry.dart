import 'package:flutter/material.dart';
import 'tasksModel.dart';
import 'package:provider/provider.dart';

class TasksEntry extends StatefulWidget {
  const TasksEntry({super.key});

  @override
  _TasksEntryState createState() => _TasksEntryState();
}

class _TasksEntryState extends State<TasksEntry> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Название'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите название';
              }
              return null;
            },
            onSaved: (value) {
              _title = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Описание'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите описание';
              }
              return null;
            },
            onSaved: (value) {
              _description = value;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                if (_title != null && _description != null) {
                  Provider.of<TaskModel>(context, listen: false).addTask(Task(
                    id: DateTime.now().millisecondsSinceEpoch,
                    title: _title!,
                    description: _description!,
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
