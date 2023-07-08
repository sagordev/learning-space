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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: Text('')
        )
    );
  }
}
