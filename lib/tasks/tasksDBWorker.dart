import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'tasksModel.dart';

class TasksDBWorker {
  static final TasksDBWorker _instance = TasksDBWorker._internal();
  late Database _db;

  factory TasksDBWorker() {
    return _instance;
  }

  TasksDBWorker._internal();

  Future<Database> get db async {
    return _db;
    _db = await _initDB();
    return _db;
  }

  Future<Database> _initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, completed INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> create(Task task) async {
    final db = await this.db;
    await db.insert('tasks', task.toMap());
  }

  Future<void> update(Task task) async {
    final db = await this.db;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await this.db;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Task>> getAll() async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<Task?> get(int id) async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Task.fromMap(maps.first);
    } else {
      return Future.value(null);
    }
  }
}
