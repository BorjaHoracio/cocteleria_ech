import 'package:cocteleria_ech/src/pages/add_module_page.dart';
import 'package:cocteleria_ech/src/pages/add_recipe_page.dart';
import 'package:cocteleria_ech/src/pages/configuration_page.dart';
import 'package:cocteleria_ech/src/pages/home_page.dart';
import 'package:cocteleria_ech/src/pages/module_page.dart';
import 'package:cocteleria_ech/src/pages/recipe_page.dart';
import 'package:cocteleria_ech/src/utils/responsive.dart';
import 'package:cocteleria_ech/src/widgets/bottombar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class RootPage extends StatefulWidget {
  static Widget create(BuildContext context)  => RootPage();
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin {
  int activeTab = 0;
  String title = '';
  List barItems = [
    {
      "icon" : LineIcons.userNinja,
      "page" : HomePage(),
    },
    {
      "icon" : LineIcons.cocktail,
      "page" : RecipePage(),
    },
    {
      "icon" : LineIcons.wineBottle,
      "page" : ModulePage(),
    },
    {
      "icon" : LineIcons.cog,
      "page" : ConfigurationPage(),
    },
  ];

  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  animatedPage(page){
    return FadeTransition(
      child: page,
      opacity: _animation
    );
  }

  void onPageChanged(int index) {
    _controller.reset();
    setState(() {
      activeTab = index;
    });
    _controller.forward();
  }
  
  void setTitle(int index){
    switch (index) {
      case 0:
        setState(() {
          title = 'Decalo de un barman';
        });
        break;
      case 1:
        setState(() {
          title = 'Recetas';
        });
        break;
      case 2:
        setState(() {
          title = 'Destilados';
        });
        break;
      case 3:
        setState(() {
          title = 'Configuración';
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          activeTab == 0 ? 'Decalo de un barman' : title,
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      bottomNavigationBar: getBottomBar(responsive),
      body: getBarPage(),
      floatingActionButton: activeTab != 0 && activeTab != 3 ? FloatingActionButton(
        backgroundColor: Colors.greenAccent.shade200,
        onPressed: () {
          switch (activeTab) {
            case 1:
              Get.to(AddRecipePage());
              break;
            case 2:
              Get.to(AddModulePage());
              break;
          }
        },
        child: Icon(LineIcons.plus),
      ) : null,
    );
  }

  Widget getBarPage(){
    return IndexedStack(
      index: activeTab,
      children: 
        List.generate(barItems.length, 
          (index) => animatedPage(barItems[index]["page"])
        )
    );
  }


  Widget getBottomBar(Responsive responsive) {
    return Container(
      height: responsive.hp(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), 
          topRight: Radius.circular(25)
        ), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 2,
            offset: Offset(1, 1)
          )
        ]
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsive.dp(3)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              barItems.length, 
              (index) => BottomBarItem(
              barItems[index]["icon"], 
              isActive: activeTab == index, 
              activeColor: Colors.deepOrange.shade600,
              size: responsive.dp(3),
              onTap: (){
                setTitle(index);
                onPageChanged(index);
              },
            )
          )
        )
      ),
    );
  }

}