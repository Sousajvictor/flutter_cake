import 'package:projeto_bolo/confeitaria.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('confeitarias.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE confeitarias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        latitude REAL,
        longitude REAL,
        cep TEXT,
        rua TEXT,
        numero TEXT,
        bairro TEXT,
        cidade TEXT,
        estado TEXT,
        telefone TEXT
      )
    ''');
  }

  Future<int> inserirConfeitaria(Confeitaria c) async {
    final db = await instance.database;
    return await db.insert('confeitarias', c.toMap());
  }

  Future<List<Confeitaria>> listarConfeitarias() async {
    final db = await instance.database;
    final result = await db.query('confeitarias');
    return result.map((map) => Confeitaria.fromMap(map)).toList();
  }

  Future<int> atualizarConfeitaria(Confeitaria c) async {
    final db = await instance.database;
    return await db.update(
      'confeitarias',
      c.toMap(),
      where: 'id = ?',
      whereArgs: [c.id],
    );
  }

  Future<int> deletarConfeitaria(int id) async {
    final db = await instance.database;
    return await db.delete(
      'confeitarias',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
