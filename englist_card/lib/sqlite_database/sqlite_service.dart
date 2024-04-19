import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'FavoriteWord.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Favorites ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "word TEXT NOT NULL,"
          "meaning TEXT NOT NULL,"
          "pronunciation TEXT NOT NULL,"
          "wordType TEXT NOT NULL,"
          "exampleSentence TEXT NOT NULL,"
          "topic TEXT NOT NULL,"
          ")",
        );
      },
      version: 1,
    );
  }
}
