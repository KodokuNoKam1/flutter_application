import 'package:flutter/material.dart';
import 'tasksModel.dart';
import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(
      builder: (context, model, child) {
        if (model.tasks.isEmpty) {
          return Center(
            child: Text('Нет задач'),
          );
        }

        return ListView.builder(
          itemCount: model.tasks.length,
          itemBuilder: (context, index) {
            var task = model.tasks[index];
            return ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  model.deleteTask(task.id);
                },
              ),
            );
          },
        );
      },
    );
  }
}
