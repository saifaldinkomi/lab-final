import 'package:database/product.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static int version = 1;
  static Database? _database;
  static String tableName = "product";

  Future<Database> get database async {
    if (database == null) _database = await db.intDB();
    return database!;
  }

  Future<Database> intDB() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      path += 'database.db',
      version: version,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS $tableName 
          (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
           name TEXT,
            email TEXT,
             password TEXT
             )
             ''');
      },
    );
  }

  Future<int> insertProduct(Product _product) async {
    final db = await database;
    return await db.insert(tableName, _product.toMap());
  }

  Future<int> removeProduct(Product _product) async {
    final db = await database;
    return await db.delete(tableName, where: 'id =?', whereArgs: [_product.id]);
  }

  Future<int> updateProduct(Product _product) async {
    final db = await database;
    return await db.update(tableName, _product.toMap(),
        where: 'id =?', whereArgs: [_product.id]);
  }

  Future<List<Product>> getAllProducts() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(tableName);
    List<Product> products = [];
    for (var element in result) {
      products.add(Product.fromMap(element));
    }
    return products;
  }

  Future<Product> getProduct(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db.query(tableName, where: 'id =?', whereArgs: [id]);
    return Product.fromMap(result[0]);
  }

  Future<int> removeall() async {
    final db = await database;
    return await db.delete(tableName);
  }
}
