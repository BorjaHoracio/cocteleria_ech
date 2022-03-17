import 'package:cocteleria_ech/src/utils/responsive.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final String textCollapsed;
  final String textExpanded;
  final String textBtn;
  final VoidCallback? onTap;
  const SettingItem({ Key? key, required this.title, this.onTap, this.textCollapsed = 'Mostrar toda la información', this.textExpanded ='Aquí va la información adicional o un texto completo de la card', this.textBtn = 'Crear'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: ExpandablePanel(
        header: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: responsive.dp(1)),
          child: Text(
            this.title,
            style: TextStyle(
              fontSize: responsive.dp(2.2),
              fontWeight: FontWeight.bold,
              color: Colors.blue
            ),
          )
        ),
        collapsed: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: responsive.dp(2)),
          child: Text(
            this.textCollapsed, 
            softWrap: true, 
            maxLines: 2, 
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: responsive.dp(1.8)
            ),
          )
        ),
        expanded: Container(
          child: Column(
            children: [
              Text(
                this.textExpanded, 
                softWrap: true,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: responsive.dp(1.8)
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              ElevatedButton(
                onPressed: onTap, 
                child: Text(textBtn)
              ),
              SizedBox(height: responsive.dp(2))
            ],
          )
        ),
      ),
    );
  }
}
