import 'package:cocteleria_ech/src/models/ingredient_model.dart';
import 'package:cocteleria_ech/src/models/recipe_model.dart';
import 'package:cocteleria_ech/src/utils/responsive.dart';
import 'package:cocteleria_ech/src/widgets/card_detail_recipe.dart';
import 'package:cocteleria_ech/src/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RecipeModel recipe = Get.arguments[0];
    final List<IngredientModel> ingredients = Get.arguments[1];
    final Responsive responsive = Responsive(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: responsive.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              HeaderDiagonal(color: recipe.color.toString()),
              Container(
                padding: EdgeInsets.only(top:20, right: 10),
                child: ListTile(
                  title: Text(
                    recipe.nameRecipe,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[200]
                    ),
                  ),
                  onTap: (){
                    Get.back();
                  },
                  leading: Icon(LineIcons.angleLeft, color: Colors.grey[200])
                ),
              ),
              Positioned(
                top: responsive.hp(16),
                child: Container(
                  child: CardDetailRecipe(
                    ingredients: ingredients,
                    recipeModel: recipe,
                    width: responsive.width!,
                    height: responsive.hp(60),
                  ),
                )
              ),
              
            ]
          ),
        ),
      )
    );
  }
}