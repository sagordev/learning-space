import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _Contacts();
}

class _Contacts extends State<Contacts>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Image.asset('assets/images/faculties.png'),
            )
        )
    );
  }
}
