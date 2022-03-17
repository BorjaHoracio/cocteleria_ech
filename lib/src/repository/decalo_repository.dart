import 'package:cocteleria_ech/src/data/db_data_source.dart';
import 'package:cocteleria_ech/src/models/decalo_model.dart';

class DecaloRepository {
  final DbDataSource _dbDataSource;

  DecaloRepository(this._dbDataSource);

  Future<List<DecaloModel>> getAllDecalo() async {
    return await _dbDataSource.getAllDecalo();
  }

}