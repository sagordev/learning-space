import 'package:flutter/material.dart';
import 'package:learning_space/views/app/dashboard/tabs/infoBooth/details/bus.dart';
import 'package:learning_space/views/app/dashboard/tabs/infoBooth/details/contacts.dart';
import 'package:learning_space/views/app/dashboard/tabs/infoBooth/details/library.dart';
import 'package:learning_space/views/app/dashboard/tabs/infoBooth/details/routine.dart';
import 'package:learning_space/views/app/dashboard/tabs/infoBooth/details/uits.dart';
import 'details/emergency.dart';
import 'details/notice.dart';
import 'details/links.dart';

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
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Notice(title: " Notices")));
          }
        ),
        getIconButton(
          icon: Icons.domain_rounded,
          text: "UITS",
          color: Colors.green,
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Uits(title: "About UITS")));
          }
        ),
        getIconButton(
            icon: Icons.contact_phone_rounded,
            text: "Contacts",
            color: Colors.purpleAccent,
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Contacts(title: "Contacts")));
            }
        ),
        getIconButton(
            icon: Icons.directions_bus_rounded,
            text: "Bus",
            color: Colors.orangeAccent,
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Bus(title: "Bus")));
            }
        ),
        getIconButton(
          icon: Icons.calendar_month_rounded,
          text: "Routine",
          color: Colors.blueAccent,
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Routine(title: "Routine")));
          }
        ),
        getIconButton(
            icon: Icons.local_florist_rounded,
            text: "Faculties",
            color: Colors.redAccent,
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Contacts(title: "Faculties")));
            }
        ),
        getIconButton(
          icon: Icons.emergency,
          text: "Emergency",
          color: Colors.lightGreen,
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Emergency(title: "Emergency Contacts")));
          }
        ),
        getIconButton(
            icon: Icons.library_books_rounded,
            text: "Library",
            color: Colors.orangeAccent,
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Library(title: "Library")));
            }
        ),
        getIconButton(
            icon: Icons.insert_link_rounded,
            text: "Links",
            color: Colors.purpleAccent,
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Links(title: " Important Links")));
            }
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