import 'package:cocteleria_ech/src/models/decalo_model.dart';
import 'package:cocteleria_ech/src/repository/decalo_repository.dart';
import 'package:get/get.dart';

class DecaloController extends GetxController{
  final decalo = <DecaloModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await loadInitialData();
  }

  Future<void> loadInitialData() async {
    decalo.value = await Get.find<DecaloRepository>().getAllDecalo();
  }

}