import 'package:cocteleria_ech/src/controllers/distilled_controller.dart';
import 'package:cocteleria_ech/src/models/distilled_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class AddModulePage extends StatelessWidget {
  var items = [    
    'Azul',
    'Rojo',
    'Amarillo',
    'Naranja',
    'Verde',
    'Rosa',
    'Aqua',
    'Morado',
    'Cafe',
    'Gris',
    'Negro',
  ];
  String dropdownvalue = 'Azul';
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistilledController>(
      init: DistilledController(),
      builder: (_) {
        _.cleanInputs();
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(LineIcons.angleLeft, color: Colors.black,),
              onPressed: (){
                Get.back();
              },
            ),
            title: Text('Agregar destilado', style: TextStyle(color: Colors.black),),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _.formKey,
                child:  Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _.distilledController,
                        onSaved: (value){
                          _.nameDistilled = value;
                        },
                        validator: (value){
                          return _.validateInput(value!);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: 'Destilado'
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _.imageController,
                        onSaved: (value){
                          _.image = value;
                        },
                        validator: (value){
                          return _.validateInput(value!);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: 'Imagen'
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _.denOrgController,
                        onSaved: (value){
                          _.denOrigen = value;
                        },
                        validator: (value){
                          return _.validateInput(value!);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: 'Denomincaión de origen'
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _.origenController,
                        onSaved: (value){
                          _.origen = value;
                        },
                        validator: (value){
                          return _.validateInput(value!);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: 'Origen'
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: _.processController,
                        onSaved: (value){
                          _.process = value;
                        },
                        validator: (value){
                          return _.validateInput(value!);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: 'Proceso'
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Obx(
                          () {
                          return DropdownButton(
                            value: _.selected.value,
                            icon: Icon(LineIcons.angleDown),
                            borderRadius: BorderRadius.circular(10),
                            isExpanded: true,
                            underline: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: items.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              _.setSelected(newValue!);
                            },
                          );
                        }
                      )
                    )
                  ],
                ),
              )
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(LineIcons.saveAlt),
            backgroundColor: Color(0xffff5d52),
            onPressed: (){
              var validation = _.checkBtn();
              if(validation == 0){
                Get.snackbar('Completar', 'Todos los campos son obligatorios');
                return;  
              }
              final distilledModel = DistilledModel(null, _.nameDistilled, _.image, _.denOrigen, _.origen, _.process, _.selected.value);
              print(distilledModel.process);
              _.getDistilled(distilledModel);
              Get.back();
            },
          ),
        );
      }
    );
  }
}

class _SelectColor extends StatefulWidget {
  _SelectColor({Key? key}) : super(key: key);

  @override
  State<_SelectColor> createState() => __SelectColorState();
}

class __SelectColorState extends State<_SelectColor> {
  var items = [    
    'Azul',
    'Rojo',
    'Amarillo',
    'Naranja',
    'Verde',
    'Rosa',
    'Aqua',
    'Morado',
    'Cafe',
    'Gris',
    'Negro',
  ];
  String dropdownvalue = 'Azul';  
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownvalue,
      icon: Icon(LineIcons.angleDown),
      borderRadius: BorderRadius.circular(10),
      underline: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }
}