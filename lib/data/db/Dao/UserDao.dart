import 'package:ana_hna/data/db/models/User.dart';
import 'package:m7db/m7db.dart';
import 'package:sqflite_common/sqlite_api.dart';

class UserDao extends M7Dao<User>{

  UserDao(Database database, String tableName) : super(database, tableName);

  @override
  User fromDB(Map<String, dynamic> map) => User.fromMap(map);

}