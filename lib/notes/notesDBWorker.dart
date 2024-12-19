import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'notesModel.dart';

class NotesDBWorker {
  static final NotesDBWorker _instance = NotesDBWorker._internal();
  late Database _db;

  factory NotesDBWorker() {
    return _instance;
  }

  NotesDBWorker._internal();

  Future<Database> get db async {
    return _db;
    _db = await _initDB();
    return _db;
  }

  Future<Database> _initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> create(Note note) async {
    final db = await this.db;
    await db.insert('notes', note.toMap());
  }

  Future<void> update(Note note) async {
    final db = await this.db;
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await this.db;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Note>> getAll() async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<Note?> get(int id) async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromMap(maps.first);
    } else {
      return Future.value(null);
    }
  }
}
