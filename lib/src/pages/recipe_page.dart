import 'package:carousel_slider/carousel_slider.dart';
import 'package:cocteleria_ech/src/controllers/recipe_controller.dart';
import 'package:cocteleria_ech/src/pages/recipe_detail_page.dart';
import 'package:cocteleria_ech/src/widgets/card_recipe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<RecipeController>(
        init: RecipeController(),
        builder: (_){
          return Obx((){
            _.loadRecipe;
            var itemCount = _.recipe.length;
            final isLoading = _.loading.value;
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    CarouselSlider(
                    options: CarouselOptions(
                      height: 290,
                      enlargeCenterPage: true,
                      disableCenter: true,
                      viewportFraction: .75,
                    ),
                    items: List.generate(
                      itemCount, 
                      (index) {
                        if (isLoading) {
                          if (index == 0) return CircularProgressIndicator();
                          index--;
                        }
                        final recipeModel = _.recipe[index];
                        return CardRecipe(
                            data: recipeModel,
                            onTap: (){
                              _.getAllIngredientsByRecipeId(recipeModel.id!);
                              Get.to(RecipeDetailPage(),transition: Transition.upToDown, arguments: [ recipeModel,  _.ingredients ]);
                            },
                            onChageFav: (){
                              var fav = recipeModel.fav == 0 ? 1 : 0;
                              var result = _.updFav(fav, recipeModel.id!);
                              if(result == 0)
                                Get.snackbar('Error', 'No se pudo dar a favorito');
                            },
                          );
                        }
                      )
                    ),
                  ],
                ),
              ),
            );
          });
        }
      ),
    );
  }
}