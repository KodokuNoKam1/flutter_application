import 'package:flutter/material.dart';
import 'tasksList.dart';
import 'tasksEntry.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Задачи'),
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
      body: _selectedIndex == 0 ? TasksList() : TasksEntry(),
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
