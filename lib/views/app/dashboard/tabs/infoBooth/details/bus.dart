import 'package:flutter/material.dart';

class Bus extends StatefulWidget {
  const Bus({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _Bus();
}

class _Bus extends State<Bus>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Image.asset('assets/images/bus.png'),
            )
        )
    );
  }
}
