import 'package:cocteleria_ech/src/models/distilled_model.dart';
import 'package:cocteleria_ech/src/utils/responsive.dart';
import 'package:cocteleria_ech/src/widgets/card_detail_distilled.dart';
import 'package:cocteleria_ech/src/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ModuleDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DistilledModel distilled = Get.arguments;
    final Responsive responsive = Responsive(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: responsive.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              HeaderDiagonal(color: distilled.color),
              Container(
                padding: EdgeInsets.only(top:20, right: 10),
                child: ListTile(
                  title: Text(
                    distilled.nameDistilled,
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
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: CardDetailDistilled(
                    distilledModel: distilled,
                    width: responsive.width!,
                    height: responsive.height!,
                  ),
                )
              )
            ]
          ),
        ),
      )
    );
  }
}