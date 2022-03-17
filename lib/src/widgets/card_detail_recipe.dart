import 'package:cocteleria_ech/src/models/ingredient_model.dart';
import 'package:cocteleria_ech/src/models/recipe_model.dart';
import 'package:cocteleria_ech/src/theme/colors.dart';
import 'package:cocteleria_ech/src/utils/responsive.dart';
import 'package:cocteleria_ech/src/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CardDetailRecipe extends StatelessWidget {
  final RecipeModel recipeModel;
  final List<IngredientModel> ingredients;
  final double width, height;

  const CardDetailRecipe({
    required this.recipeModel, 
    required this.width, 
    required this.height, 
    required this.ingredients
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      padding: EdgeInsets.only(left: responsive.dp(2), right: responsive.dp(2)),
      width: width,
      height: height,
      child: Container(
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CustomImage(
                  recipeModel.image!,
                  width: width, 
                  height: responsive.dp(30),
                  radius: 10,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: responsive.hp(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(.7),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                      )
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: EdgeInsets.all(responsive.dp(1.8)),
                    child: Icon(
                      recipeModel.fav == 0 ? LineIcons.heart : LineIcons.heartAlt,
                      size: responsive.dp(3.8),
                      color: recipeModel.fav == 0 ? Colors.grey[300] : Colors.pinkAccent,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: responsive.dp(1.2),right: responsive.dp(1.2),top: responsive.dp(1.2)),
              child: Column(
                children: [
                  Text('Ingredientes'),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: responsive.dp(1.2),
                    children: List.generate(
                      ingredients.length, 
                      (index) {
                        return Chip(
                          shape: StadiumBorder(
                            side: BorderSide(
                              width: 1.5,
                              color: CustomColor().getColor(recipeModel.color)!,
                            )
                          ),
                          backgroundColor: Colors.transparent,
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(ingredients[index].nameIngredient),
                              Text(ingredients[index].amount),
                            ],
                          ),
                        );
                      }
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8),
            Divider(
              height: 2.5,
              indent: responsive.wp(8),
              endIndent: responsive.wp(8),
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.only(left: responsive.dp(1.2),right: responsive.dp(1.2),top: responsive.dp(1.2)),
              child: Column(
                children: [
                  Text('Preparación'),
                  Text(
                    recipeModel.preparation,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: responsive.dp(2)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Divider(
              height: 2.5,
              indent: responsive.wp(8),
              endIndent: responsive.wp(8),
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}