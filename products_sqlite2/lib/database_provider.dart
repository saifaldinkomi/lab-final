import 'package:sqflite/sqflite.dart';
import 'package:sqlite_example/product.dart';
import 'package:path/path.dart';
class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static const version = 1;
  static Database? _database;
  final String tableName = 'products';
  Future<Database?>  get database async{
    if(_database != null)
      return _database;
    _database = await initDB();
    return _database;

  }
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    path += 'products.db';
    return await openDatabase(
      path,
      version: version,
      onCreate: (db, version) async{
          await db.execute('''
          create table $tableName (
          id integer primary key autoincrement,
          pName text not null, 
          quantity integer not null, 
          price double not null
          )
          ''');
      },
    );
  }
  Future insertProduct(Product p) async{
    final db = await database;
    return await db?.insert(tableName, p.toMap());
  }
  Future updateProduct(Product p) async{
    final db = await database;
    return await db?.update(tableName, p.toMap(),where: 'id=?',whereArgs: [p.id]);
  }

  Future<List<Product>> getProducts() async{
    final db = await database;
    List<Map<String, dynamic>>? result =  await db?.query(tableName,orderBy: 'id asc');
    List<Product> products = [];
    result?.forEach((element) {
      products.add(Product.fromMap(element));
    });
    return products;
  }
  Future removeProduct(int id) async{
    final db = await database;
    return await db?.delete(tableName,where: 'id = ?',whereArgs: [id]);
  }
  Future removeAll() async{
    final db = await database;
    return await db?.delete(tableName);
  }
}




























