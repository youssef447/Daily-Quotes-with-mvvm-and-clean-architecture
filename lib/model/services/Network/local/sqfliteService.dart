import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'IlocalService.dart';

class SqfliteService implements ILocalService {
  final String dbName = "QuoteDatabase.db";

  final String todayTableName = "TodayQuote";
  final String favTableName = "FavoriteQuotes";

  Database? _database;

  @override
  Future<void> initializeDB() async {
    if (_database == null) {
      String path = await getDatabasesPath();

      _database = await openDatabase(
        join(path, dbName),
        onCreate: (database, version) async {
          await database.execute(
            "CREATE TABLE $todayTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, q TEXT NOT NULL, a TEXT NOT NULL, fav bool NOT NULL)",
          );
          await database.execute(
            "CREATE TABLE $favTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, q TEXT NOT NULL, a TEXT NOT NULL, fav bool NOT NULL)",
          );
        },
        version: 1,
      );
    } else {
      return;
    }
  }

  @override
  Future<void> addTodayQuote(Map<String, dynamic> query) async {
    await initializeDB();

    await _database!.transaction(
      (txn) => txn.insert(
        todayTableName,
        query,
      ),
    );
  }

  @override
  Future<Map> getTodayQuote() async {
    await initializeDB();
    //database.rawQuery('select* from $table');
    final map = await _database!.query(
      todayTableName,
    );

    return map[0];
  }

  @override
  Future<void> updateTodayQuote(Map<String, dynamic> query) async {    await initializeDB();

      await _database!.update(
      todayTableName,
      query,
      where: 'id= ?',
      whereArgs: [1],
    ); 
      
  }

  @override
  Future<void> addFavQuote(Map<String, dynamic> query) async {
    await initializeDB();

    await _database!.transaction(
      (txn) => txn.insert(
        favTableName,
        query,
      ),
    );
  }

  @override
  Future<List<Map>> getFavQuotes() async {
    await initializeDB();
    //database.rawQuery('select* from $table');
    List<Map> list = await _database!.query(
      favTableName,
    );

    return list;
  }

  @override
  Future<void> removeFromFav(String quoteText) async {
    await initializeDB();

    await _database!.delete(
      favTableName,
      where: "q= ?",
      whereArgs: [quoteText],
    );
  }
}
