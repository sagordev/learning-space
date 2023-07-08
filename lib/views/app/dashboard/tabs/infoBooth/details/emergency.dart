import 'package:flutter/material.dart';

class Emergency extends StatefulWidget{
  const Emergency({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _Emergency();
}
class _Emergency extends State<Emergency>{
  @override
  Widget build(BuildContext context) {
    var arrName =[ 'Various government services  333', ' Police, fire service and ambulance services 999 ',
    'women and children are abused 109 ', '	Dudok Helpline 106' , 'Disaster warning in advance 1090',
      ' Bangladesh Police helpdesk 100' ,' RAB helpdesk 101 ', 'Fire Service Hotline 102',
    'National Identity Card 105', 'Government legal assistance 16430'];
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:ListView.separated(itemBuilder: (context,index){
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(arrName[index], style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500)),
              )
            ],
          );
        },
          itemCount: arrName.length,
          scrollDirection: Axis.vertical,
          separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 40,);
          },

    )

    );
  }
}
