import 'package:carousel_slider/carousel_slider.dart';
import 'package:cocteleria_ech/src/controllers/distilled_controller.dart';
import 'package:cocteleria_ech/src/pages/add_module_page.dart';
import 'package:cocteleria_ech/src/pages/module_detail_page.dart';
import 'package:cocteleria_ech/src/utils/responsive.dart';
import 'package:cocteleria_ech/src/widgets/card_distilled.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ModulePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return GetBuilder<DistilledController>(
      init: DistilledController(),
      builder: (controller){
      return Obx((){
        var itemCount = controller.distilled.length;
        final isLoading = controller.loading.value;
        if (isLoading) itemCount++;
          return SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      disableCenter: true,
                      viewportFraction: .75,
                      height: responsive.dp(32),
                    ),
                    items: List.generate(
                      itemCount, 
                      (index) {
                        if (isLoading) {
                          if (index == 0) return CircularProgressIndicator();
                          index--;
                        }
                        final distilled = controller.distilled[index];
                        return CardDistilled(
                          data: distilled,
                          onTap: (){
                            controller.loadRecipeByDistilledId(distilled.id!);
                            Get.to(ModuleDetailPage(),duration: Duration(milliseconds: 700), transition: Transition.circularReveal, arguments: distilled);
                          },
                        );
                      })
                  ),
                  SizedBox(height: 15),
                ]
              ),
            ),
          );  
        }
      );
    });
  }
}