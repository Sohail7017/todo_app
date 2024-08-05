import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Private Constructor
class DbHelper{

  DbHelper._();
  static final DbHelper getInstance = DbHelper._();


  /// My Database
  Database? myDB;

 Future<Database> getDB() async{
      myDB ??=  await openDB();
      return myDB!;

  }
  Future<Database>openDB() async{
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String rootsPath = appDirectory.path;

    String dbPath = join(rootsPath, "todo.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db , version){

      /// Table Create
      db.rawQuery("create table todoData (s_no integer primary key autoincrement, tittle text, desc text)");

    });
  }
}