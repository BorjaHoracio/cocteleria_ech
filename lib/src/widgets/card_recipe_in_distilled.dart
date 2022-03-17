
import 'package:cocteleria_ech/src/models/recipe_model.dart';
import 'package:cocteleria_ech/src/utils/responsive.dart';
import 'package:cocteleria_ech/src/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CardRecipeInDistilled extends StatelessWidget {
  CardRecipeInDistilled({ Key? key, required this.data, this.onTap}) : super(key: key);
  final RecipeModel data;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.only(top: responsive.dp(3), left: responsive.dp(1), bottom: responsive.dp(3)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
              ),
            ],
          ),
          child: Row(
            children: [
              CustomImage(
                data.image!,
                isShadow: true,
                radius: 15,
                height: 80,
              ),
              SizedBox(width: responsive.dp(1)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      child: Text(
                        data.nameRecipe,
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: responsive.dp(1.5)),
                  Icon(
                    data.fav == 0 ? LineIcons.heart : LineIcons.heartAlt,
                    size: responsive.dp(3.8),
                    color: data.fav == 0 ? Colors.black: Colors.pinkAccent,
                  ),
                ],
              )
            ],
          )
        ),
    );
  }
}