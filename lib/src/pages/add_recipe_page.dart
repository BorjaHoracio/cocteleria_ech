import 'package:cocteleria_ech/src/controllers/recipe_controller.dart';
import 'package:cocteleria_ech/src/models/distilled_model.dart';
import 'package:cocteleria_ech/src/models/ingredient_model.dart';
import 'package:cocteleria_ech/src/models/recipe_model.dart';
import 'package:cocteleria_ech/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class AddRecipePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return GetBuilder<RecipeController>(
      init: RecipeController(),
      builder: (_) {
        _.loadDistilled();
        return Obx(
          () {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(LineIcons.angleLeft, color: Colors.black,),
                  onPressed: (){
                    Get.back();
                  },
                ),
                title: Text('Agregar Receta', style: TextStyle(color: Colors.black),),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: _.formKey,
                  child:  ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _.nameController,
                          onSaved: (value){
                            _.name = value;
                          },
                          validator: (value){
                            return _.validateInput(value!);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            labelText: 'Receta'
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
                          // validator: (value){
                          //   return _.validateInput(value!);
                          // },
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
                          controller: _.metElaController,
                          onSaved: (value){
                            _.metEla = value;
                          },
                          validator: (value){
                            return _.validateInput(value!);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            labelText: 'Metodo de elaboración'
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _.tipoVasoController,
                          onSaved: (value){
                            _.tipoVaso = value;
                          },
                          validator: (value){
                            return _.validateInput(value!);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            labelText: 'Tipo de vaso'
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _.decorationController,
                          onSaved: (value){
                            _.decoration= value;
                          },
                          validator: (value){
                            return _.validateInput(value!);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            labelText: 'Decoración'
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: _.preparationController,
                          onSaved: (value){
                            _.preparation = value;
                          },
                          validator: (value){
                            return _.validateInput(value!);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            labelText: 'Preparación'
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Obx(
                            () {
                              return DropdownButton(
                                hint: Text("Seleccione el destilado"),
                                value: _.selected.value,
                                icon: Icon(LineIcons.angleDown),
                                borderRadius: BorderRadius.circular(10),
                                underline: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: _.distilled.map((e) {
                                  return DropdownMenuItem(
                                    value: e.id.toString(),
                                    child: Text(e.nameDistilled),
                                  );
                                }).toList(),
                                onChanged: (String? value){
                                  _.setSelected(value!);
                                },
                              );
                            }
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx((){
                                return Checkbox(
                                  value: _.check.value,
                                  onChanged: (bool? value) {
                                    _.setCheck(value!);
                                  },
                                );
                              }),
                              Text('Es de certificación'),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: (responsive.width! / 3),
                                  child: TextFormField(
                                    controller: _.ingredientController,
                                    onSaved: (value){
                                      _.ingredient = value;
                                    },
                                    // validator: (value){
                                    //   return _.validateInput(value!);
                                    // },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      labelText: 'Ingrediente'
                                    ),
                                  ),
                                ),
                                Container(
                                  width: (responsive.width! / 3),
                                  child: TextFormField(
                                    controller: _.amountController,
                                    onSaved: (value){
                                      _.amount = value;
                                    },
                                    // validator: (value){
                                    //   return _.validateInput(value!);
                                    // },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      labelText: 'Cantidad'
                                    ),
                                  )
                                ),
                              ],
                            ),
                            Container(
                              child: ElevatedButton(
                                onPressed: (){
                                  var validation = _.checkBtn();
                                  if(validation == 0){
                                    Get.snackbar('Completar', 'Todos los campos son obligatorios');
                                    return;  
                                  }
                                  _.addIngredient(_.ingredient, _.amount);
                                  _.cleanInputsIngredients();
                                }, 
                                child: Text('Agregar')
                              ),
                            ),
                            Container(
                              height: 200,
                              child: ListView.builder(
                                itemCount: _.ingredients.length,
                                itemBuilder: (context, index){
                                  return ListTile(
                                    trailing: IconButton(
                                      icon: Icon(LineIcons.trash),
                                      onPressed: (){
                                        _.ingredients.remove(_.ingredients[index]);
                                      },
                                    ),
                                    title: Text(_.ingredients[index].nameIngredient),
                                    subtitle: Text(_.ingredients[index].amount),
                                  );
                              }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Color(0xffff5d52),
                onPressed: (){
                  var validation = _.checkBtn();
                  if(validation == 0){
                    Get.snackbar('Completar', 'Todos los campos son obligatorios');
                    return;  
                  }
                  final recipe = RecipeModel(null, int.parse(_.selected.value), null, _.name, _.image, _.metEla, _.check.value ? 1:0, _.tipoVaso, _.decoration, _.preparation,0);
                  _.insertRecipe(recipe,_.ingredients);
                  _.cleanInputs();
                  Get.back();
                },
                child: Icon(LineIcons.saveAlt),
              ),
            );
          }
        );
      }
    );
  }
}