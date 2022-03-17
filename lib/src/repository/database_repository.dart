import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert' as convert;
import 'package:encrypt/encrypt.dart' as encrypt;

class DatabaseRepository {
  late final Database _db;

  static const SECRET_KEY = "2022_PRIVATE_KEY_ENCRYPT";
  static const DATABASE_VERSION = 2;

  List<String> tables =['distilled','beer','recipe', 'ingredient', 'decalo'];

  Future<Database> get db async {
    // if(_db != null){
    //   return _db;
    // } 
    // else{
    // }
      _db = await initDb(DATABASE_VERSION);
      return _db;
  }

  Future<String> _databasePath() async {
    String databasesPath = await getDatabasesPath();
    return join(databasesPath, "cocteles.db");
  }

  Future<Database> initDb(int version) async {
    String path = await _databasePath();
    return await openDatabase(path, version:version, onCreate: onCreate,onUpgrade: onUpgrade);
  }

  Future deleteDB() async {
    String path = await _databasePath();
    await deleteDatabase(path);
  }

  Future onCreate(Database db, int newerVersion) => this._onCreates[newerVersion]!(db);

  Map<int,Function> _onCreates = {
    1:(Database db) async {
      print("DATABASE CREATE v1");
    },
    2:(Database db) async{
      print("DATABASE CREATE v2");
    },
    3:(Database db) async{
      print("DATABASE CREATE v3");
    },
  };

  Future<void> onUpgrade(Database db , int oldVersion, int newVersion ) async {
    for (var migration = oldVersion; migration < newVersion; migration++) {
      this._onUpgrades["from_version_${migration}_to_version_${migration+1}"]!(db);
    }
  }

  Map<String,Function> _onUpgrades = {
    'from_version_1_to_version_2':(Database db) async {
      print('from_version_1_to_version_2');
    },'from_version_2_to_version_3':(Database db) async {
      print('from_version_2_to_version_3');
    },
  };

  Future clearAllTables() async {
    try {
      var dbs = await this.db;
      for (String table  in []){
        await dbs.delete(table);
        await dbs.rawQuery("DELETE FROM sqlite_sequence where name='$table'");
      }
      print('------ CLEAR ALL TABLE');
    }
    catch(e){}
  }

  Future<String>generateBackup({bool isEncrypted = true}) async {
    print('GENERATE BACKUP');
    var dbs = await this.db;
    List data =[];
    List<Map<String,dynamic>> listMaps=[];
    for (var i = 0; i < tables.length; i++){
      listMaps = await dbs.query(tables[i]); 
      data.add(listMaps);
    }
    List backups=[tables,data];
    String json = convert.jsonEncode(backups);
    if(isEncrypted){
      var key = encrypt.Key.fromUtf8(SECRET_KEY);
      var iv = encrypt.IV.fromLength(16);
      var encrypter = encrypt.Encrypter(encrypt.AES(key));
      var encrypted = encrypter.encrypt(json, iv: iv);
      return encrypted.base64;  
    }
    else{
      return json;
    }
  }

  Future<void>restoreBackup(String backup,{ bool isEncrypted = true}) async {
    var dbs = await this.db;
    Batch batch = dbs.batch();
    var key = encrypt.Key.fromUtf8(SECRET_KEY);
    var iv = encrypt.IV.fromLength(16);
    var encrypter = encrypt.Encrypter(encrypt.AES(key));
    List json = convert.jsonDecode(isEncrypted ? encrypter.decrypt64(backup,iv:iv):backup);
    for (var i = 0; i < json[0].length; i++){
      for (var k = 0; k < json[1][i].length; k++){
        batch.insert(json[0][i],json[1][i][k]);
      }
    }
    await batch.commit(continueOnError:false,noResult:true);
    print('RESTORE BACKUP');
  }
}