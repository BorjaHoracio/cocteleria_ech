import 'package:cocteleria_ech/src/app.dart';
import 'package:cocteleria_ech/src/data/db_data_source.dart';
import 'package:cocteleria_ech/src/repository/decalo_repository.dart';
import 'package:cocteleria_ech/src/repository/distilled_repository.dart';
import 'package:cocteleria_ech/src/repository/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbDataSource = await DbDataSource.init();
  final distilledRepository = DistilledRepository(dbDataSource);
  final recipeRepository = RecipeReposiroty(dbDataSource);
  final decaloRepository = DecaloRepository(dbDataSource);

  Get.put(distilledRepository);
  Get.put(recipeRepository);
  Get.put(decaloRepository);

  runApp(MyApp());
}