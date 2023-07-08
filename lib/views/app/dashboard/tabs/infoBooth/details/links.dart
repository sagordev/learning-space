import 'package:flutter/material.dart';

class Links extends StatefulWidget {
  const Links({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _Links();
}

class _Links extends State<Links>{
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
