import 'dart:async';
import 'dart:io';

import 'package:my_movie_browser/data/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal( );

  factory DatabaseHelper ()=> _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
    print("Table is created");
  }

  //insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<User> getUser (int id)  async {
    var dbClient = await db;
    var map;
    try {
      map = dbClient.rawQuery(
          "SELECT "
              "username, "
              "password "
              "FROM User "
              "WHERE id = " + id.toString( )
      );
    } catch (e) {
      print( e );
    }
    print(map);
    return new User(map[0][0],map[0][1]);
    //return new Future.value(new User(username, password)
    //return tempUser;
  }
}