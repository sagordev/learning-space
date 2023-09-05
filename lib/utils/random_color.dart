import 'package:flutter/material.dart';

class RandomColor {
  static final List<Color> colors = [
    Colors.green,
    Colors.deepPurple,
    Colors.blue,
    Colors.teal,
    Colors.redAccent,
  ];

  static Color getRandomColor(int index){
    return colors[index % colors.length];
  }
}