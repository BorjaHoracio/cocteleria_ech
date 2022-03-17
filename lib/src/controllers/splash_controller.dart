import 'dart:io';

import 'package:cocteleria_ech/src/pages/root_app_page.dart';
import 'package:cocteleria_ech/src/repository/database_repository.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  
  late SharedPreferences preferences;

  Directory findRoot(FileSystemEntity entity) {
    final Directory parent = entity.parent;
    if (parent.path == entity.path) return parent;
    return findRoot(parent);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    loadPreferences().then((value) => initData());
  }

  void initData() async{
    final bool? setData = preferences.getBool('setData');
    if(setData == null){
      var cadena = await rootBundle.loadString('assets/dbBakcup.text');
        final DatabaseRepository databaseRepository = new DatabaseRepository();
        await databaseRepository.restoreBackup(cadena, isEncrypted: true);
        await preferences.setBool('setData', true);
        Get.to(RootPage(), transition: Transition.zoom);
    }
  }

  Future<void> loadPreferences () async {
    preferences = await Get.putAsync(() async => await SharedPreferences.getInstance());
  }

}
