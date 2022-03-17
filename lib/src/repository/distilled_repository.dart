import 'package:cocteleria_ech/src/data/db_data_source.dart';
import 'package:cocteleria_ech/src/models/distilled_model.dart';
import 'package:cocteleria_ech/src/models/recipe_model.dart';

class DistilledRepository {
  final DbDataSource _dbDataSource;

  DistilledRepository(this._dbDataSource);

  Future<DistilledModel> NewDistilled(DistilledModel distilled) async {
    await _dbDataSource.save(distilled);
    return distilled;
  }

  Future<List<DistilledModel>> getAllDistilled() async {
    return _dbDataSource.getAllDistilled();
  }

  Future<List<RecipeModel>> getAllRecipeByDistilledId(int distilledId) async {
    return _dbDataSource.getAllRecipeByDistilledId(distilledId);
  }

}