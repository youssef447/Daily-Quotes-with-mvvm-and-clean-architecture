import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'IlocalService.dart';

class SqfliteService implements ILocalService{
  final String dbName = "QuoteDatabase.db";

  final String tableName = "Quotes";
  Database? _database;

  @override
  Future<void> initializeDB() async {
    if (_database == null) {
      String path = await getDatabasesPath();

      _database = await openDatabase(
        join(path, dbName),
        onCreate: (database, version) async {
          await database.execute(
            "CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, q TEXT NOT NULL, a TEXT NOT NULL)",
          );
        },
        version: 1,
      );
    } else {
      return;
    }
  }
  @override

  Future<List<Map>> getQuotes() async {
    await initializeDB();
    //database.rawQuery('select* from $table');
    List<Map> list = await _database!.query(
      tableName,
    );

    return list;
  }
  @override

  Future<void>addQuote(Map<String, dynamic> query) async {
    await initializeDB();
    await _database!.transaction(
      (txn) => txn.insert(
        tableName,
        query,
      ),
    );
  }
  @override

  Future<void>deleteQuote(int id) async {
    await initializeDB();

    await _database!.delete(
      tableName,
      where: "id= ?",
      whereArgs: [id],
    );
  }
}
