import 'package:cocteleria_ech/src/models/decalo_model.dart';
import 'package:cocteleria_ech/src/models/distilled_model.dart';
import 'package:cocteleria_ech/src/models/ingredient_model.dart';
import 'package:cocteleria_ech/src/models/recipe_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'script_db.dart';

class DbDataSource {
  static Future<DbDataSource> init() async {
    final aux = DbDataSource();
    await aux._init();
    return aux;
  }

  late final Database db;

  Future<void> _init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cocteles.db');
    List<String> createTables = [tablaDestilado,tablaCerveza,tablaRecetas,tablaIngredientes,tablaDecalo];
    db = await openDatabase(path, version: 2,
        onCreate: (Database newDb, int version) async {
          for(String i in createTables){
            await newDb.execute(i);
          }
        });
  }

  Future<int> save(DistilledModel toSave) {
    return db.transaction((txn) async {
      int Id = await txn.insert(
        'distilled',
        toSave.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return Id;
    });
    // return db.insert(
    //   'distilled',
    //   toSave.toMapForDb(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
  }
  Future<int> saveRecipe(RecipeModel toSave, List<IngredientModel> ingredients) {
    return db.transaction((txn) async {
      int Id = await txn.insert(
        'recipe',
        toSave.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await saveIngredient(ingredients, Id);
      return Id;
    });
    // return db.insert(
    //   'recipe',
    //   toSave.toMapForDb(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
  }

  Future<int> saveIngredient(List<IngredientModel> ingredients, int idRecipe) async {
    var res = 0;
    try {
      ingredients.forEach((ingredient) async {
          await db.transaction((txn) async {
            int Id = await txn.rawInsert('INSERT INTO ingredient (idRecipe, nameIngredient, amount) VALUES(?, ?, ?)', [idRecipe, ingredient.nameIngredient, ingredient.amount]);
          return Id;
    });
      });
      return res;
    } catch (e) {
      return res;
    }
  }

  Future<List<DistilledModel>> getAllDistilled() async {
    const query =
        'SELECT * FROM distilled';
    final queryResult = await db.rawQuery(query);
    return queryResult.map((e) => DistilledModel.fromMap(e)).toList();
  }

  Future<int> updFav(int fav, int id) async {
    return db.rawUpdate('UPDATE recipe SET fav = ? WHERE id = ?',[fav,id]);
  }

  Future<List<RecipeModel>> getAllRecipeByDistilledId(int distilledId) async {
    const query = 'SELECT r.*, d.nameDistilled, d.color FROM distilled as d INNER JOIN recipe as r on d.id = r.idDistilled WHERE r.idDistilled = ?';
    final queryResult = await db.rawQuery(query, [distilledId]);
    return queryResult.map((e) => RecipeModel.fromMap(e)).toList();
  }

  Future<List<IngredientModel>> getAllIngredientsByRecipeId(int recipeId) async {
    const query = 'SELECT i.* FROM ingredient as i INNER JOIN recipe as r on i.idRecipe = r.id WHERE r.id = ?';
    final queryResult = await db.rawQuery(query, [recipeId]);
    return queryResult.map((e) => IngredientModel.fromMap(e)).toList();
  }

  Future<List<RecipeModel>> getAllRecipe() async {
    const query =
        'select r.*, d.nameDistilled, d.color from recipe as r inner join distilled as d on r.idDistilled = d.id';
    final queryResult = await db.rawQuery(query);
    return queryResult.map((e) => RecipeModel.fromMap(e)).toList();
  }

  Future<List<DecaloModel>> getAllDecalo() async {
    const query = 'select * from decalo';
    final queryResult = await db.rawQuery(query);
    return queryResult.map((e) => DecaloModel.fromMap(e)).toList();
  }
}

























