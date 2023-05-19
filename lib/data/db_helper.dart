import 'package:login_signup_refactoring/domain/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbHelper {
  static Database? _db;

  static const String dbName = 'test.db';
  static const String tableUser = 'user';
  static const int version = 1;

  static const String cID = '_id';
  static const String cUserID = 'userId';
  static const String cUserName = 'userName';
  static const String cEmail = 'email';
  static const String cPassword = 'password';
  static const String cGender = 'gender';
  static const String cAge = 'age';
  static const String cRepeated = 'repeated';
  static const String cSelectDate = 'selectDate';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    // _db = await testInitDb();
    return _db!;
  }

  testInitDb() async {
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        onCreate: _onCreate,
        version: version,
      ),
    );
    return db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(
      path,
      version: version,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $tableUser ("
        " $cID INTEGER PRIMARY KEY AUTOINCREMENT,"
        " $cUserID TEXT NOT NULL, "
        " $cUserName TEXT NOT NULL, "
        " $cEmail TEXT NOT NULL, "
        " $cPassword TEXT NOT NULL, "
        " $cGender TEXT NOT NULL, "
        " $cAge INTEGER NOT NULL, "
        " $cRepeated TEXT NOT NULL, "
        " $cSelectDate TEXT NOT NULL "
        ")");
  }

  // Future<int> saveData(UserModel user) async {
  //   var dbClient = await db;
  //   var res = await dbClient.insert(tableUser, user.toMap());
  //   return res;
  // }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  Future<int> insertUser(Map<String, dynamic> row) async {
    var dbClient = await db;
    return await dbClient.insert(tableUser, row);
  }

  // Future<void> insertUser(UserModel user) async {
  //   var dbClient = await db;
  //   await dbClient.insert(tableUser, user.toJson());
  // }

  Future<UserModel?> getLoginUser(String userId, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableUser WHERE "
        "$cUserID = '$userId' AND "
        "$cPassword = '$password'");
    if (res.isNotEmpty) {
      return UserModel.fromJson(res.first);
    }
    return null;
  }

  // Future<List<UserModel>> queryAllUser() async {
  //   var dbClient = await db;
  //   final maps = await dbClient.query(tableUser);
  //   return maps.map((e) => UserModel.fromJson(e)).toList();
  // }

  // Future<UserModel?> queryOneUser(int id) async {
  //   var dbClient = await db;
  //   final List<Map<String, dynamic>> maps = await dbClient.query(
  //     tableUser,
  //     where: 'id =?',
  //     whereArgs: [id],
  //   );
  //   if (maps.isNotEmpty) {
  //     return UserModel.fromJson(maps.first);
  //   }
  //   return null;
  // }

  Future<int> updateUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.update(tableUser, user.toJson(),
        where: '$cID = ?', whereArgs: [user.id]);
    return res;
  }

  // Future<void> queryAllUser() async {
  //   var dbClient = await db;
  //   await dbClient.query(tableUser);
  // }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    var dbClient = await db;
    return await dbClient.query(tableUser);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT _id FROM $tableUser'));
  }

  // cUserID: String , int cID : _id 있어야 한다!!
  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    var dbClient = await db;
    var res =
        await dbClient.delete(tableUser, where: '$cID = ?', whereArgs: [id]);
    return res;
  }

  // We are assuming here that the id column in the map is set.
  // The other column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    var dbClient = await db;
    int id = row[cID];
    return await dbClient.update(
      tableUser,
      row,
      where: '$cID = ?',
      whereArgs: [id],
    );
  }
}
