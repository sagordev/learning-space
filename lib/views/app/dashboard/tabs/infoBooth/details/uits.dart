import 'package:flutter/material.dart';

class Uits extends StatefulWidget{
  const Uits({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _Uits();
}

class _Uits extends State<Uits>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Text("Write here university details")
      )
    );
  }
  
}