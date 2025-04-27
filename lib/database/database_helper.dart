import 'package:projeto_bolo/confeitaria.dart';
import 'package:projeto_bolo/produto.dart'; // Certifique-se de importar sua classe Produto
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

    return await openDatabase(path, version: 3, onCreate: _createDB, onUpgrade: _onUpgrade);
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

    await db.execute('''  
      CREATE TABLE produtos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        valor REAL,
        descricao TEXT,
        imagem TEXT, 
        confeitariaId INTEGER, 
        FOREIGN KEY (confeitariaId) REFERENCES confeitarias (id)
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await db.execute('''  
        CREATE TABLE IF NOT EXISTS produtos (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          valor REAL,
          descricao TEXT,
          imagem TEXT, 
          confeitariaId INTEGER, 
          FOREIGN KEY (confeitariaId) REFERENCES confeitarias (id)
        )
      ''');
    }
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

  // Função para inserir um produto
  Future<int> inserirProduto(Produto produto) async {
    final db = await instance.database;
    return await db.insert('produtos', produto.toMap());
  }

  // Função para listar os produtos
  Future<List<Produto>> listarProdutos() async {
    final db = await instance.database;
    final result = await db.query('produtos');
    return result.map((map) => Produto.fromMap(map)).toList();
  }

  // Listar produtos de uma confeitaria específica
  Future<List<Produto>> listarProdutosDaConfeitaria(int confeitariaId) async {
    final db = await instance.database;
    final result = await db.query(
      'produtos',
      where: 'confeitariaId = ?',
      whereArgs: [confeitariaId],
    );
    return result.map((map) => Produto.fromMap(map)).toList();
  }

  // Função para atualizar um produto
  Future<int> atualizarProduto(Produto produto) async {
    final db = await instance.database;
    return await db.update(
      'produtos',
      produto.toMap(),
      where: 'id = ?',
      whereArgs: [produto.id],
    );
  }

  // Função para deletar um produto
  Future<int> deletarProduto(int produtoId) async {
    final db = await instance.database;
    return await db.delete(
      'produtos',
      where: 'id = ?',
      whereArgs: [produtoId],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
