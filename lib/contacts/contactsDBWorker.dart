import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'contactsModel.dart';

class ContactsDBWorker {
  static final ContactsDBWorker _instance = ContactsDBWorker._internal();
  late Database _db;

  factory ContactsDBWorker() {
    return _instance;
  }

  ContactsDBWorker._internal();

  Future<Database> get db async {
    return _db;
    _db = await _initDB();
    return _db;
  }

  Future<Database> _initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'contacts.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, phone TEXT, email TEXT, address TEXT, avatar TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> create(Contact contact) async {
    final db = await this.db;
    await db.insert('contacts', contact.toMap());
  }

  Future<void> update(Contact contact) async {
    final db = await this.db;
    await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await this.db;
    await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Contact>> getAll() async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query('contacts');

    return List.generate(maps.length, (i) {
      return Contact.fromMap(maps[i]);
    });
  }

  Future<Contact?> get(int id) async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      return Future.value(null);
    }
  }
}
