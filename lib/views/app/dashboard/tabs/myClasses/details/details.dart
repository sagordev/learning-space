import 'package:flutter/material.dart';

class Details extends StatefulWidget{
  const Details({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _Details();
}

class _Details extends State<Details>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Text("This is test"),
        ),
      ),
    );
  }

}