import 'package:cocteleria_ech/src/data/db_data_source.dart';
import 'package:cocteleria_ech/src/models/ingredient_model.dart';
import 'package:cocteleria_ech/src/models/recipe_model.dart';

class RecipeReposiroty {
  final DbDataSource _dbDataSource;

  RecipeReposiroty(this._dbDataSource);

  Future<RecipeModel> NewRecipe(RecipeModel recipe, List<IngredientModel> ingredients) async {
    await _dbDataSource.saveRecipe(recipe, ingredients);
    return recipe;
  }

  Future<List<RecipeModel>> getAllRecipe() async {
    return _dbDataSource.getAllRecipe();
  }

  Future<int> updFav(int fav, int id) async {
    return _dbDataSource.updFav(fav, id);
  }

  Future<List<IngredientModel>> getAllIngredientsByRecipeId(int recipeId) async {
    return _dbDataSource.getAllIngredientsByRecipeId(recipeId);
  }

}