import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class QuoteLocalService {
  final String dbName = "QuoteDatabase.db";

  final String todayTableName = "TodayQuote";
  final String favTableName = "FavoriteQuotes";
  final String myQuotesTableName = "MyQuotesPage";

  Database? _database;

  Future<void> initializeDB() async {
    if (_database == null) {
      String path = await getDatabasesPath();

      _database = await openDatabase(
        join(path, dbName),
        onCreate: (database, version) async {
          await database.execute(
            "CREATE TABLE $myQuotesTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, q TEXT NOT NULL, a TEXT NOT NULL, fav bool NOT NULL)",
          );
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

  Future<void> cacheTodayQuote(Map<String, dynamic> query) async {
    await initializeDB();

    await _database!.transaction(
      (txn) => txn.insert(
        todayTableName,
        query,
      ),
    );
  }

  Future<Map> getTodayQuote() async {
    await initializeDB();
    //database.rawQuery('select* from $table');
    final map = await _database!.query(
      todayTableName,
    );

    return map[0];
  }

  Future<void> updateTodayQuote(Map<String, dynamic> query) async {
    await initializeDB();

    await _database!.update(
      todayTableName,
      query,
      where: 'id= ?',
      whereArgs: [1],
    );
  }

  Future<void> addFavQuote(Map<String, dynamic> query) async {
    await initializeDB();

    await _database!.transaction(
      (txn) => txn.insert(
        favTableName,
        query,
      ),
    );
  }

  Future<List<Map>> getFavQuotes() async {
    await initializeDB();
    //database.rawQuery('select* from $table');
    List<Map> list = await _database!.query(
      favTableName,
    );

    return list;
  }

  Future<void> removeFromFav(String quoteText) async {
    await initializeDB();

    await _database!.delete(
      favTableName,
      where: "q= ?",
      whereArgs: [quoteText],
    );
  }

  Future<void> addMyQuotesPageService(Map<String, dynamic> query) async {
    await initializeDB();

    await _database!.transaction(
      (txn) => txn.insert(
        myQuotesTableName,
        query,
      ),
    );
  }

  Future<void> deleteMyQuotesPageService(int id) async {
    await initializeDB();

    await _database!.delete(
      myQuotesTableName,
      where: "id= ?",
      whereArgs: [id],
    );
  }

  Future<void> updateMyQuotesPageService(Map<String, dynamic> query) async {
    await initializeDB();

    await _database!.update(
      myQuotesTableName,
      query,
      where: 'id= ?',
      whereArgs: [query['id']],
    );
  }

  Future<List<Map>> geMyQuotesPage() async {
    await initializeDB();
    //database.rawQuery('select* from $table');
    List<Map> list = await _database!.query(
      myQuotesTableName,
    );

    return list;
  }
}
