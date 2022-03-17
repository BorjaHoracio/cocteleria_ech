import 'package:flutter/material.dart';

class SettingBox extends StatelessWidget {
  SettingBox({ Key? key, required this.title, required this.icon, this.color = Colors.black }) : super(key: key);
  final title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), 
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          SizedBox(height: 7,),
          Text(title, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w500),)
        ],
      ),
    );
  }
}