import 'package:cocteleria_ech/src/models/distilled_model.dart';
import 'package:cocteleria_ech/src/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CardDistilled extends StatelessWidget {
  CardDistilled({ Key? key, required this.data, this.width = 280, this.height = 290, this.onTap}) : super(key: key);
  final DistilledModel data;
  final double width;
  final double height;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return 
      GestureDetector(
        onLongPress: () {
          print('longpress');
        },
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 5, top: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              CustomImage(
                data.image,
                width: double.infinity, height: 190,
                radius: 15,
              ),
              Positioned(
                top: 170, right: 15,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: getColor(data.color),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Text(data.nameDistilled, 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Positioned(
                top: 210,
                child: Container(
                  width: width - 20,
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getAttribute(LineIcons.mapMarked, Colors.greenAccent, data.origen),
                          getAttribute(LineIcons.globe, Colors.red.shade300, data.denOrigen),
                          SizedBox(width: 12,),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }

  Color? getColor(String color){
    switch (color) {
      case 'Azul':
        return Colors.blue.shade500;
      case 'Rojo':
        return Colors.redAccent.shade400;
      case 'Amarillo':
        return Colors.yellowAccent.shade400;
      case 'Naranja':
        return Colors.orangeAccent.shade400;
      case 'Verde':
        return Colors.greenAccent.shade400;
      case 'Rosa':
        return Colors.pinkAccent.shade400;
      case 'Aqua':
        return Colors.cyanAccent.shade400;
      case 'Morado':
        return Colors.purpleAccent.shade400;
      case 'Cafe':
        return Colors.brown.shade400;
      case 'Gris':
        return Colors.grey.shade600;
      case 'Negro':
        return Colors.black;
      default:
        return Colors.blue;
    }
  }

  getAttribute(IconData icon, Color color, String info){
    return
      Row(
        children: [
          Icon(icon, size: 18, color: color,),
          SizedBox(width: 3,),
          Text(info, maxLines: 1, overflow: TextOverflow.ellipsis, 
            style: TextStyle(fontSize: 13),
          ),
        ],
      );
  }

}