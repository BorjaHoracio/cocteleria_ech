import 'package:cocteleria_ech/src/models/distilled_model.dart';
import 'package:cocteleria_ech/src/models/ingredient_model.dart';
import 'package:cocteleria_ech/src/models/recipe_model.dart';
import 'package:cocteleria_ech/src/repository/distilled_repository.dart';
import 'package:cocteleria_ech/src/repository/recipe_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipeController extends GetxController {
  final loading = false.obs;
  var distilled = <DistilledModel>[].obs;
  var recipe = <RecipeModel>[].obs;
  var ingredients = <IngredientModel>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController 
  nameController, 
  imageController, 
  metElaController,
  tipoVasoController, 
  decorationController, 
  preparationController,
  ingredientController,
  amountController;

  var name, image, metEla, tipoVaso, decoration, preparation, ingredient, amount;
  var check = false.obs;
  var selected = '1'.obs;

  @override
  void onInit() {
    super.onInit();
    loadDistilled();
    loadRecipe();
    nameController = TextEditingController();
    imageController = TextEditingController();
    metElaController = TextEditingController();
    tipoVasoController = TextEditingController();
    decorationController = TextEditingController();
    preparationController = TextEditingController();
    ingredientController = TextEditingController();
    amountController = TextEditingController();
  }

  @override
  void onClose() {
    nameController.dispose();
    imageController.dispose();
    metElaController.dispose();
    tipoVasoController.dispose();
    decorationController.dispose();
    preparationController.dispose();
    ingredientController.dispose();
    amountController.dispose();
    check.value = false;
  }

  void addIngredient(String ingredient, String amount){
    final newIngredient = IngredientModel(null,ingredient, amount);
    ingredients.insert(0, newIngredient);
  }

  void setCheck(bool? value){
    check.value = value!;
  }

  void setSelected(String value){
    selected.value = value;
  }

  String? validateInput(String value) {
    if (value == '') {
      return "Campo obligatorio";
    }
    return null;
  }

  int checkBtn() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return 0;
    }
    formKey.currentState!.save();
    return 1;
  }

  void cleanInputsIngredients(){
    ingredientController.text = '';
    amountController.text = '';
  }

  void cleanInputs() {
    nameController.text = '';
    imageController.text = '';
    metElaController.text = '';
    tipoVasoController.text = '';
    decorationController.text = '';
    preparationController.text = '';
    ingredientController.text = '';
    amountController.text = '';
    check.value = false;
  }
  Future<void> loadDistilled() async {
    distilled.value = await Get.find<DistilledRepository>().getAllDistilled();
  }
  Future<void> loadRecipe() async {
    recipe.value = await Get.find<RecipeReposiroty>().getAllRecipe();
  }

  Future<void> getAllIngredientsByRecipeId(int recipeId) async {
    ingredients.value = await Get.find<RecipeReposiroty>().getAllIngredientsByRecipeId(recipeId);
  }
  
  Future<void> loadRecipeByDistilledId(int distilledId) async {
    recipe.value = await Get.find<DistilledRepository>().getAllRecipeByDistilledId(distilledId);
  }

  Future<void> insertRecipe(RecipeModel recipeModel, List<IngredientModel> ingredients) async {
    if (loading.isTrue) return;
    loading.value = true;
    var newRecipe = await Get.find<RecipeReposiroty>().NewRecipe(recipeModel, ingredients);
    recipe.insert(0, newRecipe);
    loadRecipe();
    loading.value = false;
  }

  Future<int> updFav(int fav, int id) async {
    var result = await Get.find<RecipeReposiroty>().updFav(fav, id);
    loadRecipe();
    return result;
  }

}