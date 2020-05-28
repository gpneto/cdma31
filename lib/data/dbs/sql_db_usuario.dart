import 'dart:async';
import 'dart:io';


import 'package:cdma31/model/serializers.dart';
import 'package:cdma31/model/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';





class DBProviderUsuario {
  DBProviderUsuario._();

  static final DBProviderUsuario db = DBProviderUsuario._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  void createUsuarioTable(Batch batch) {

    batch.execute("CREATE TABLE Usuario ("
        "uid TEXT PRIMARY KEY,"
        "pass TEXT,"
        "passEncrypt TEXT,"
        "salt TEXT,"
        "email TEXT,"
        "name TEXT,"
        "image TEXT,"
        "imageLocal TEXT,"
        "UNIQUE(uid)"
        ")");
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "usuarioRepoPass3.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        var batch = db.batch();
        createUsuarioTable(batch);
        await batch.commit();
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        var batch = db.batch();
        await batch.commit();
      },
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  newUsuario(User newUser) async {
    final db = await database;
    //get the biggest id in the table
    var raw;

    User user;
    try {
      user = await DBProviderUsuario.db.getUser(newUser.uid);
    }catch(e){
      print(e);
    }
    if (user != null) {
      updateUser(newUser);
    } else {
      //insert to the table using the new id
      var batch = db.batch();
      batch.rawInsert(
          "INSERT OR IGNORE Into Usuario (uid,pass,passEncrypt,salt,email,name,image,imageLocal)"
          " VALUES (?,?,?,?,?,?,?,?)",
          [
            newUser.uid,
            newUser.pass,
            newUser.passEncrypt,
            newUser.salt,
            newUser.email,
            newUser.name,
            newUser.image,
            newUser.imageLocal
          ]);
      batch.commit(noResult: true);
    }

    return raw;
  }


  getUser(String id) async {
    final db = await database;
    var res =
        await db.query("Usuario", where: "uid = ?", whereArgs: [id]);

    return res.isNotEmpty ? standardSerializers.deserializeWith(
        User.serializer,  res.first ) : null;
  }




  updateUserPhoto(User user) async {

    final db = await database;
    var batch = db.batch();

    batch.rawUpdate(
          "UPDATE Usuario SET image = ?, imageLocal = ? WHERE uid = ? ",
          [
            user.image,
            user.imageLocal,
            user.uid
          ]);
    batch.commit(noResult: true);

  }

  updateUser(User user) async {

    final db = await database;

    if(user.pass != null ){
      var batch = db.batch();
      batch.rawUpdate(
          "UPDATE Usuario SET  pass= ?, passEncrypt = ? , salt = ? , email = ?, name = ?, "
              "image = ?, imageLocal = ? WHERE uid = ? ",
          [
            user.pass,
            user.passEncrypt,
            user.salt,
            user.email,
            user.name,
            user.image,
            user.imageLocal,
            user.uid
          ]);
      batch.commit(noResult: true);
    }else{
      var batch = db.batch();
      batch.rawUpdate(
          "UPDATE Usuario SET  email = ?, name = ?, "
              "image = ?, imageLocal = ? WHERE uid = ? ",
          [
            user.email,
            user.name,
            user.image,
            user.imageLocal,
            user.uid
          ]);
      batch.commit(noResult: true);
    }

  }

}
