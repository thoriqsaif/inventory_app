import 'package:inventory_app/data/db/db/data_inventory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String _databaseName = 'inventory_app.db';
  static const String _tableName = 'list_inventory';
  static const int _version = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future createTables(Database database) async {
    await database.execute("""
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        quantity INTEGER,
        price INTEGER
      )
    """);
  }

  Future<Database> _initializeDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _version,
      onCreate: (Database db, int version) async {
        await createTables(db);
      },
    );
  }

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDB();
    return _database!;
  }

  Future<int> addInventory(DataInventory dataInventory) async {
    final db = await database;
    final data = dataInventory.toJson();

    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<DataInventory>> getAllInventory() async {
    final db = await database;
    final results = await db.query(_tableName);
    return results.map((result) => DataInventory.fromJson(result)).toList();
  }

  Future<bool> isInventory(int index) async {
    final db = await database;
    final results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [index],
      limit: 1,
    );
    return results.isNotEmpty;
  }

  Future<int> removeInventory(int index) async {
    final db = await database;
    final result = await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [index],
    );
    return result;
  }
}
