import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'product.dart';

class DatabaseProvider extends ChangeNotifier {
  DatabaseProvider._privateConstructor();

  static final DatabaseProvider instance =
      DatabaseProvider._privateConstructor();
  static Database? _database;
  static const int version = 2;
  static int selectedProductedId = -1;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'uniDB.db');
    return openDatabase(path, version: version,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE product (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          quantity int,
          price REAL
          )
          ''');
    }, onUpgrade: (Database db, int oldversion, int newversion) {});
  }

  Future<int> add(Product p) async {
    final db = await database;
    int rawId = await db.insert('product', p.toMap());
    notifyListeners();
    return rawId;
  }

  Future<int> delete(int id) async {
    final db = await database;
    int cnt = await db.delete('product', where: 'id = ?', whereArgs: [id]);
    notifyListeners();
    return cnt;
  }

  Future<List<Product>> getAllProduct() async {
    final db = await database;
    List<Map<String, dynamic>> map = await db.query('product');
    List<Product> prds = [];
    for (var element in map) {
      prds.add(Product.fromMap(element));
    }
    return prds;
  }

  Future<int> update(Product p) async {
    final db = await database;
    int cnt = await db
        .update('product', p.toMap(), where: 'id = ?', whereArgs: [p.id]);
    notifyListeners();
    return cnt;
  }

  Future<Product> getProduct(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db.query('product', where: 'id = ?', whereArgs: [id]);
    Product p = Product.fromMap(result[0]);
    return p;
  }
}
