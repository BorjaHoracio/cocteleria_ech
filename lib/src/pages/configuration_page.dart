import 'dart:io';

import 'package:cocteleria_ech/src/repository/database_repository.dart';
import 'package:cocteleria_ech/src/widgets/setting_item.dart';
import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({Key? key}) : super(key: key);

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: getBody()
          )
        ],
      )
    );
  }

  Widget getBody() {
    return 
    SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          SizedBox(height: 20,),
          SettingItem(
            title: 'Backup',
            textCollapsed: 'Para saber mas sobre esta sección de un toque para expandir',
            textExpanded: 'En esta sección podrá guardar toda la información de la aplicación, se le creara este directorio dentro de su dispositivo en esta ruta "Mi Barra/Backup" creando un archivo dbBackup.text que es podrá restaurar en un futuro si lo desea.',
            textBtn: 'Crear backup',
            onTap: () async{
              try {
                final dbFolder = await getDatabasesPath();
                File source1 = File('$dbFolder/cocteles.db');
                Directory copyTo = Directory("storage/emulated/0/MiBarra/Backup");
                if ((await copyTo.exists())) {
                  var status = await Permission.storage.status;
                  print(status.isGranted);
                  if (!status.isGranted) {
                    await Permission.storage.request();
                  }
                } else {
                  print("not exist");
                  if (await Permission.storage.request().isGranted) {
                    copyTo.createSync(recursive: true);
                  } else {
                    print('no tengo permiso');
                    Get.snackbar('Error', 'No tiene permiso para hacer modificaciones');
                  }
                }

                // String newPath2 = "${copyTo.path}/cocteles.db";
                // await source1.copy(newPath2);
                final DatabaseRepository databaseRepository = new DatabaseRepository();
                String backup =  await databaseRepository.generateBackup(isEncrypted: true);

                // new Directory.fromUri(Uri.parse("storage/emulated/0/MiBarra/Backup")).createSync(recursive: true);
                String newPath = "storage/emulated/0/MiBarra/Backup/dbBackup.text";
                final File file = File(newPath);    
                await file.writeAsString(backup);
                Get.snackbar('Exitoso', 'Se ha guardado la información en Mi Barra/Backup');
              } catch (e) {
                print('entro al catch: $e');
                Get.snackbar('Error', 'Ha ocurrido un error contacte al desarrollador');
              }
            },
          ),
          SizedBox(height: 20),
          SettingItem(
            title: 'Restore',
            textCollapsed: 'Para saber mas sobre esta sección de un toque para expandir',
            textExpanded: 'En esta sección podrá recupar la información si cuenta un el archivo dbBackup.text que se realizo en el backup o en se defecto que le hayan proporcionado dicho archivo.',
            textBtn: 'Recuperar info',
            onTap: () async {
              try {
                FilePickerResult? result = await FilePicker.platform.pickFiles();
                final DatabaseRepository databaseRepository = new DatabaseRepository();

                if (result != null) {
                  File source = File(result.files.single.path!);
                  String data = await source.readAsString();
                  await databaseRepository.restoreBackup(data,isEncrypted: true);
                  Get.snackbar('Listo', 'Se ha restaurado la información');
                } else {
                  Get.snackbar('Error', 'No se pudo cargar el archivo');
                }
              } catch (e) {
                  Get.snackbar('Error', 'Ha ocurrido un error contacte al desarrollador');
                  print(e);
              }
            },
          ),
          
        ]
      ),
    );
  }

}

// Container (
//         child: ListView(
//           children: [
//             Text(message),
//             ElevatedButton(
//               onPressed: () async {
//                 final dbFolder = await getDatabasesPath();
//                 File source1 = File('$dbFolder/cocteles.db');
//                 Directory copyTo =
//                     Directory("storage/emulated/0/Sqlite Backup");
//                 if ((await copyTo.exists())) {
//                   // print("Path exist");
//                   var status = await Permission.storage.status;
//                   if (!status.isGranted) {
//                     await Permission.storage.request();
//                   }
//                 } else {
//                   print("not exist");
//                   if (await Permission.storage.request().isGranted) {
//                     // Either the permission was already granted before or the user just granted it.
//                     await copyTo.create();
//                   } else {
//                     print('Please give permission');
//                   }
//                 }

//                 String newPath = "${copyTo.path}/cocteles.db";
//                 await source1.copy(newPath);

//                 setState(() {
//                   message = 'Successfully Copied DB';
//                 });
//               }, 
//               child: Text('Backup')
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 var databasesPath = await getDatabasesPath();
//                 var dbPath = join(databasesPath, 'cocteles.db');

//                 FilePickerResult? result =
//                     await FilePicker.platform.pickFiles();

//                 if (result != null) {
//                   File source = File(result.files.single.path!);
//                   await source.copy(dbPath);
//                   setState(() {
//                   message = 'Successfully Restored DB';
//                 });
//                 } else {
//                   // User canceled the picker

//                 }
//               }, 
//               child: Text('Restore')
//             ),
//           ],
//         ),
//       )