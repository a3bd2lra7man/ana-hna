import 'dart:async';
import 'package:ana_hna/data/db/models/User.dart';
import 'package:m7db/m7db.dart';
import 'package:sqflite_common/sqlite_api.dart';

class AppDB extends M7DB{

  static AppDB _appDB;

  AppDB._();

  factory AppDB(){
    if(_appDB == null) _appDB = AppDB._();
    return _appDB;
  }

  @override
  String get databaseName => 'App.db';

  @override
  FutureOr<void> onCreate(Database db, int version)async {
    await db.execute(createTableStatement(tableName: User.tableName,fields: User.fields));
  }

  @override
  int get version => 1;

}