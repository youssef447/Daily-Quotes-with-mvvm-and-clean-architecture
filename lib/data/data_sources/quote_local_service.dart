import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class QuoteLocalService {
  final String _dbName = "QuoteDatabase.db";

  final String _todayTableName = "TodayQuote";
  final String _favTableName = "FavoriteQuotes";
  final String _myQuotesTableName = "MyQuotesPage";

  Database? _database;

  Future<void> initializeDB() async {
    if (_database == null) {
      String path = await getDatabasesPath();

      _database = await openDatabase(
        join(path, _dbName),
        onCreate: (database, version) async {
          await database.execute(
            "CREATE TABLE $_myQuotesTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, q TEXT NOT NULL, a TEXT NOT NULL, fav bool NOT NULL)",
          );
          await database.execute(
            "CREATE TABLE $_todayTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, q TEXT NOT NULL, a TEXT NOT NULL, fav bool NOT NULL)",
          );
          await database.execute(
            "CREATE TABLE $_favTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, q TEXT NOT NULL, a TEXT NOT NULL, fav bool NOT NULL)",
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
        _todayTableName,
        query,
      ),
    );
  }

  Future<Map> getTodayQuote() async {
    await initializeDB();
    //database.rawQuery('select* from $table');
    final map = await _database!.query(
      _todayTableName,
    );

    return map[0];
  }

  Future<void> updateTodayQuote(Map<String, dynamic> query) async {
    await initializeDB();

    await _database!.update(
      _todayTableName,
      query,
      where: 'id= ?',
      whereArgs: [1],
    );
  }

  Future<void> addFavQuote(Map<String, dynamic> query) async {
    await initializeDB();

    await _database!.transaction(
      (txn) => txn.insert(
        _favTableName,
        query,
      ),
    );
  }

  Future<List<Map>> getFavQuotes() async {
    await initializeDB();
    //database.rawQuery('select* from $table');
    List<Map> list = await _database!.query(
      _favTableName,
    );

    return list;
  }

  Future<void> removeFromFav(String quoteText) async {
    await initializeDB();

    await _database!.delete(
      _favTableName,
      where: "q= ?",
      whereArgs: [quoteText],
    );
  }

  Future<void> addMyQuotesPageService(Map<String, dynamic> query) async {
    await initializeDB();

    await _database!.transaction(
      (txn) => txn.insert(
        _myQuotesTableName,
        query,
      ),
    );
  }

  Future<void> deleteMyQuotesPageService(int id) async {
    await initializeDB();

    await _database!.delete(
      _myQuotesTableName,
      where: "id= ?",
      whereArgs: [id],
    );
  }

  Future<void> updateMyQuotesPageService(Map<String, dynamic> query) async {
    await initializeDB();

    await _database!.update(
      _myQuotesTableName,
      query,
      where: 'id= ?',
      whereArgs: [query['id']],
    );
  }

  Future<List<Map>> geMyQuotesPage() async {
    await initializeDB();
    //database.rawQuery('select* from $table');
    List<Map> list = await _database!.query(
      _myQuotesTableName,
    );

    return list;
  }
}
