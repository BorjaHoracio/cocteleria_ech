import 'package:carousel_slider/carousel_slider.dart';
import 'package:cocteleria_ech/src/controllers/distilled_controller.dart';
import 'package:cocteleria_ech/src/controllers/recipe_controller.dart';
import 'package:cocteleria_ech/src/models/distilled_model.dart';
import 'package:cocteleria_ech/src/pages/recipe_detail_page.dart';
import 'package:cocteleria_ech/src/utils/responsive.dart';
import 'package:cocteleria_ech/src/widgets/card_recipe_in_distilled.dart';
import 'package:cocteleria_ech/src/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDetailDistilled extends StatelessWidget {
  final DistilledModel distilledModel;
  final double width, height;

  const CardDetailDistilled({
    required this.distilledModel, 
    required this.width, 
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      padding: EdgeInsets.only(left: responsive.dp(2), right: responsive.dp(2)),
      width: width,
      height: height,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomImage(
              distilledModel.image,
              width: width, 
              height: 190,
              radius: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: responsive.dp(1.2),right: responsive.dp(1.2),top: responsive.dp(1.2)),
              child: Text(
                distilledModel.process,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: responsive.dp(1.2),right: responsive.dp(1.2),top: responsive.dp(1.2)),
              child: Text(
                'Denomincaión de origen ${distilledModel.denOrigen}',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: responsive.dp(1.2),right: responsive.dp(1.2),top: responsive.dp(1.2)),
              child: Text(
                'Su origen es ${distilledModel.origen}',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            SizedBox(height: 8),
            Divider(
              height: 2.5,
              indent: responsive.wp(8),
              endIndent: responsive.wp(8),
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.only(left: responsive.dp(1.2),right: responsive.dp(1.2),top: responsive.dp(1.2)),
              child: Column(
                children: [
                  Text('Recetas con este destilado'),
                  SizedBox(height: responsive.dp(1.2)),
                  Container(
                    child: GetBuilder<RecipeController>(
                      init: RecipeController(),
                      builder: (_) {
                        _.loadRecipeByDistilledId(distilledModel.id!);
                        var recipe = _.recipe;
                        return CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 21/9,
                            // autoPlay: true,
                            enlargeCenterPage: true,
                            disableCenter: true,
                            viewportFraction: .75,
                          ),
                          items: List.generate(
                            recipe.length, 
                            (index) {
                              _.getAllIngredientsByRecipeId(recipe[index].id!);
                              return CardRecipeInDistilled(
                                data: recipe[index],
                                onTap: (){
                                  Get.to(RecipeDetailPage(), arguments: [recipe[index], _.ingredients]);
                                },
                              );
                            }
                          ),
                        );
                    }),
                  )              
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}