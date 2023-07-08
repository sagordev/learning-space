import 'package:flutter/material.dart';
import 'package:learning_space/views/app/dashboard/tabs/myClasses/details/discussion.dart';

class Details extends StatefulWidget{
  const Details({super.key, required this.title, required this.color});
  final String title;
  final Color color;
  @override
  State<StatefulWidget> createState() => _Details();
}

class _Details extends State<Details>{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: widget.color,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(child: Text("Discussion"),),
                Tab(child: Text("Participants"),)
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: TabBarView(
              children: [
                Discussion(color: widget.color),
                Text("Tab 2")
              ],
            )
          ),
        )
    );
  }

}