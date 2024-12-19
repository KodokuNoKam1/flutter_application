import 'package:flutter/foundation.dart';
import 'tasksDBWorker.dart';

class Task {
  int id;
  String title;
  String description;
  bool completed;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed ? 1 : 0,
    };
  }

  Task.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        completed = map['completed'] == 1;
}

class TaskModel extends ChangeNotifier {
  List<Task> _tasks = [];
  final TasksDBWorker _dbWorker = TasksDBWorker();

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _dbWorker.create(task).then((_) {
      _tasks.add(task);
      notifyListeners();
    });
  }

  void deleteTask(int id) {
    _dbWorker.delete(id).then((_) {
      _tasks.removeWhere((task) => task.id == id);
      notifyListeners();
    });
  }

  void toggleTaskCompletion(int id) {
    Task task = _tasks.firstWhere((task) => task.id == id);
    task.completed = !task.completed;
    _dbWorker.update(task).then((_) {
      notifyListeners();
    });
  }

  void loadTasks() async {
    _tasks = await _dbWorker.getAll();
    notifyListeners();
  }
}

final taskModel = TaskModel();
