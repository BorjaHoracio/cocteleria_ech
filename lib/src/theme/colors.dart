import 'package:flutter/material.dart';

class CustomColor {
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
}