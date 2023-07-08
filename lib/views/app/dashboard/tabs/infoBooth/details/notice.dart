import 'package:flutter/material.dart';

class Notice extends StatefulWidget {
  const Notice({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _Notice();
}

class _Notice extends State<Notice>{
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
