import 'package:flutter/material.dart';

class InfoBooth extends StatelessWidget{
  const InfoBooth({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3
        ),
      children: [
        getIconButton(
          icon: Icons.campaign_rounded,
          text: "Notice",
          color: Colors.redAccent,
          onPressed: (){}
        ),
        getIconButton(
          icon: Icons.domain_rounded,
          text: "UITS",
          color: Colors.green,
          onPressed: (){}
        ),
        getIconButton(
            icon: Icons.contact_phone_rounded,
            text: "Contacts",
            color: Colors.purpleAccent,
            onPressed: (){}
        ),
        getIconButton(
            icon: Icons.directions_bus_rounded,
            text: "Bus",
            color: Colors.orangeAccent,
            onPressed: (){}
        ),
        getIconButton(
          icon: Icons.calendar_month_rounded,
          text: "Routine",
          color: Colors.blueAccent,
          onPressed: (){}
        ),
        getIconButton(
            icon: Icons.local_florist_rounded,
            text: "Faculties",
            color: Colors.redAccent,
            onPressed: (){}
        ),
        getIconButton(
          icon: Icons.emergency,
          text: "Emergency",
          color: Colors.lightGreen,
          onPressed: (){}
        ),
        getIconButton(
            icon: Icons.library_books_rounded,
            text: "Library",
            color: Colors.orangeAccent,
            onPressed: (){}
        ),
        getIconButton(
            icon: Icons.insert_link_rounded,
            text: "Links",
            color: Colors.purpleAccent,
            onPressed: (){}
        )
      ],
    );
  }

  Widget getIconButton({icon, text, color, onPressed}){
    return TextButton(
      onPressed: (){onPressed();},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.all(Radius.circular(50))
              ),
              child: Icon(icon, size: 40, color: color),
            ),
            Text(text, style: TextStyle(color: Colors.black, fontSize: 13),)
          ],
        )
    );
  }

}