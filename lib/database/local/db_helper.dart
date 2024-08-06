import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Private Constructor
class DbHelper {
  DbHelper._();

  static final DbHelper getInstance = DbHelper._();
  static final String tableName = "todoData";
  static final String tableColumnSNo = "S_no";
  static final String tableColumntittle = "title";
  static final String tableColumnDesc = "desc";

  /// My Database
  Database? myDB;

  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String rootsPath = appDirectory.path;

    String dbPath = join(rootsPath, "todo.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      /// Table Create
      db.rawQuery(
          "create table $tableName ($tableColumnSNo integer primary key autoincrement, $tableColumntittle text, $tableColumnDesc text)");
    });
  }

  /// queries
  /// insert data
  Future<bool> addTask({required String title, required String desc}) async {
    var db = await getDB();

    int rowsEffected = await db.insert(tableName, {
      tableColumntittle: title,
      tableColumnDesc: desc,
    });
    return rowsEffected > 0;
  }

  /// get all data
  Future<List<Map<String, dynamic>>> getAllTasks() async {
    var db = await getDB();

    var allTasks = await db.query(tableName);
    return allTasks;
  }

  ///Update Task

    Future<bool> updateTask({required String title, required String desc , required int sNo}) async{
          var db = await getDB();

        int rowsEffected = await db.update(tableName, {
          tableColumntittle: title,
          tableColumnDesc: desc,},
        where: "$tableColumnSNo = $sNo"
        );
        return rowsEffected>0;

  }

  /// delete Task
    Future<bool> deleteTask({required int sNo})async{
    var db = await getDB();

    int rowsEffected = await db.delete(tableName, where: "$tableColumnSNo = ?", whereArgs: ['$sNo']);
    return rowsEffected>0;
  }


}
