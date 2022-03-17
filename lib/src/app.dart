import 'package:cocteleria_ech/src/pages/root_app_page.dart';
import 'package:cocteleria_ech/src/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {

  Future<bool?> sharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? setData = prefs.getBool('setData');
    return setData;
  }

  @override
  Widget build(BuildContext context) {
    final Future<bool?> setData = sharedPreferences();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0
        )
      ),
      title: 'Coctelería',
      home: SafeArea(
        child: FutureBuilder<bool?>(
          future: setData,
          builder: (BuildContext context, AsyncSnapshot<bool?  > snapshot){
            print(snapshot.data);
            return snapshot.data != null ? RootPage() : SplashPage();
          },
        )
      ),
    );
  }
}