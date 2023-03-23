import 'package:path/path.dart';
import 'package:quotes/globals/globals.dart';
import 'package:quotes/helper/quotes_api_helper.dart';
import 'package:quotes/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class QuotesDB {
  QuotesDB._();

  static final QuotesDB quotesDB = QuotesDB._();

  final String databaseName = "Quotes.db";
  final String colId = "id";
  final String colQuot = "content";
  final String colAuthor = "author";
  final String colImage = "image";

  late Database database;

  Future<void> createDB({required String tableName}) async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, databaseName);

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colQuot TEXT, $colAuthor TEXT, $colImage BLOB);");
    });
  }

  Future<void> insertRecord({required String tableName}) async {
    await createDB(tableName: tableName);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isInserted = prefs.getBool(tableName) ?? false;

    if (isInserted == false) {
      List<Quotes>? data =
          await QuotesAPI.quotesAPI.getData(tableName: tableName);

      for (int i = 0; i < data!.length; i++) {
        String query =
            "INSERT INTO $tableName($colQuot, $colAuthor, $colImage) VALUES(?, ?, ?);";
        List args = [data[i].quot, data[i].author, data[i].image];

        await database.rawInsert(query, args);
      }
      prefs.setBool(tableName, true);
    }
  }

  Future<List<QuotesD>> fetchAllRecords({required String tableName}) async {
    await insertRecord(tableName: tableName);

    String query = "SELECT * FROM $tableName;";
    List<Map<String, dynamic>> allQuotes = await database.rawQuery(query);

    List<QuotesD> quotes =
        allQuotes.map((e) => QuotesD.fromData(data: e)).toList();
    Global.isAuthor = false;

    return quotes;
  }
}
