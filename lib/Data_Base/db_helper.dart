import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //Singleton Class
  // 1 Private Constructor
  DBHelper._();
  // 2 Globally distribute
  //Signal Line Return
  //getInstance() function
  static DBHelper getInstance() => DBHelper._();

  //Database Global Variable
  Database? dataBase;

  static final String TABLE_NOTE_NAME = "note";
  static final String COLUMN_NOTE_ID = "id";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DESC = "desc";

  // GetDB
  Future<Database> getDB() async {
    if (dataBase != null) {
      return dataBase!;
    } else {
      dataBase = await openDB();
      return dataBase!;
    }
  }

//function Data open
  Future<Database> openDB() async {
    var appDir = await getApplicationDocumentsDirectory();

    var dbPath = join(appDir.path, "Notes.db");
    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      // Create Table
      db.execute(
          "create table $TABLE_NOTE_NAME ( $COLUMN_NOTE_ID integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text ) ");
    });
  }

  // db Function (quires) Insert Data
  Future<bool> addNote({required String title, required String desc}) async {
    var db = await getDB();
    int rowsEffected = await db.insert(TABLE_NOTE_NAME, {
      COLUMN_NOTE_TITLE: title,
      COLUMN_NOTE_DESC: desc,
    });
    return rowsEffected > 0;
  }

  //get allNotes
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(TABLE_NOTE_NAME);
    return mData;
  }
}
