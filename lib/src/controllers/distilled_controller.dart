import 'package:cocteleria_ech/src/models/distilled_model.dart';
import 'package:cocteleria_ech/src/models/recipe_model.dart';
import 'package:cocteleria_ech/src/repository/distilled_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DistilledController extends GetxController{
  final loading = false.obs;
  final distilled = <DistilledModel>[].obs;
  final recipe = <RecipeModel>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController distilledController, imageController,denOrgController,origenController,processController, colorController;

  var nameDistilled, image, denOrigen, origen, process, color;
  final selected = "Azul".obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
    distilledController = TextEditingController();
    imageController = TextEditingController();
    denOrgController = TextEditingController();
    origenController = TextEditingController();
    processController = TextEditingController();
    colorController = TextEditingController();
  }
  
  @override
  void onClose() {
    distilledController.dispose();
    imageController.dispose();
    denOrgController.dispose();
    origenController.dispose();
    processController.dispose();
    colorController.dispose();
  }

  String? validateInput(String value) {
    if (value == '') {
      return "Campo obligatorio";
    }
    return null;
  }
  void setSelected(String value){
    selected.value = value;
  }
  void cleanInputs (){
    distilledController.text = '';
    imageController.text = '';
    denOrgController.text = '';
    origenController.text = '';
    processController.text = '';
    colorController.text = '';
    selected.value = 'Azul';
  }
  int checkBtn() {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return 0;
    }
    formKey.currentState!.save();
    return 1;
  }

  Future<void> loadInitialData() async {
    distilled.value = await Get.find<DistilledRepository>().getAllDistilled();
  }

  Future<void> loadRecipeByDistilledId(int distilledId) async {
    recipe.value = await Get.find<DistilledRepository>().getAllRecipeByDistilledId(distilledId);
  }

  Future<void> getDistilled(DistilledModel distilledModel) async {
    if (loading.isTrue) return;
    loading.value = true;
    final newDistilled = await Get.find<DistilledRepository>().NewDistilled(distilledModel);
    distilled.insert(0, newDistilled);
    await loadInitialData();
    loading.value = false;
  }


}