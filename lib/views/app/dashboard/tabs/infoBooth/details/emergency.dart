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
    List<Map<String, dynamic>> contacts = [
      {'Emergency': 999},
      {'Various govt. services': 333},
      {'Women and children abused': 109},
      {'Dudok Helpline': 106},
      {'Disaster warning in advance': 1090},
      {'Bangladesh Police helpdesk': 105},
      {'Government legal assistance': 16430}
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: ListView.separated(itemBuilder: (context,index){
            return Row(
              children: [
                Expanded(
                  flex: 2,
                    child: Text(contacts[index].keys.first)
                ),
                Expanded(
                  flex: 1,
                    child: SelectableText('${contacts[index].values.first}', style: TextStyle(fontWeight: FontWeight.bold),)
                )
              ],
            );
          },
            itemCount: contacts.length,
            scrollDirection: Axis.vertical,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 30,);
            },

          ),
        )

    );
  }
}
