import 'package:flutter/material.dart';

class Avatar extends StatelessWidget{
  const Avatar({super.key, this.photo});
  final String? photo;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: photo == null || photo == "" ? Icon(Icons.person, color: Colors.grey,) : SizedBox() ,
      backgroundColor: Color(0xFFDFDFDF),
      backgroundImage: photo == null || photo == "" ? null : NetworkImage('$photo'),
      // onBackgroundImageError: (_, st){
      //   //
      // },
    );
  }

}