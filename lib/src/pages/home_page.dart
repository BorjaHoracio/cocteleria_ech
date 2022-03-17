import 'package:cocteleria_ech/src/controllers/decalo_controller.dart';
import 'package:cocteleria_ech/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return GetBuilder<DecaloController>(
      init: DecaloController(),
      builder: (_) {
        _.loadInitialData();
        var decalo = _.decalo;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    height: responsive.height,
                    child: Obx(
                      () => ListView.separated(
                        itemCount: decalo.length,
                        separatorBuilder: (context, index) => Container(height: 20,),
                        itemBuilder: (context, index){
                          return Container(
                            height: responsive.dp(4),
                            child: Flexible(
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  '${decalo[index].id}-. ${decalo[index].nameDecalo}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: responsive.dp(1.8),
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ),
                  ),
                )
              )
            ]
          )
        );
      }
    );
  }

}