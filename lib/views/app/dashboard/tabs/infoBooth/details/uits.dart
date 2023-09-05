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
        child: SingleChildScrollView(
          child: Expanded(
              child: Column(
                children: [
                  Image.asset('assets/images/uits-building.jpg'),
                  SingleChildScrollView(
                    child: Text("The University of Information Technology and Sciences (UITS), "
                        "the first IT-based private university in Bangladesh, was founded on August 7, 2003, as a non-profit organization,"
                        "The vice chancellor of the university is the chief executive. Each academic department has its own head. On top of the administration,"
                        " there is the Board of Trustees (BoT), headed by a chairperson, which oversees policy matters. "
                        "In the academic sphere, the highest authority is vested in the Academic Council represented by heads of schools and teaching departments,"
                        " representatives of teachers and nominated members who are associated with education, science, culture, industries, media and scientific and cultural organizations in the country. "
                        "The council is presided over by the vice chancellor. The registrar of the university acts as the secretary who is also the custodian of the university seal."
                      , style: TextStyle(fontSize: 17), textAlign: TextAlign.justify,
                    ),
                  )
                ],
              )
          ),
        )
      )
    );
  }
  
}