import 'package:flutter/material.dart';

class MyClasses extends StatefulWidget{
  const MyClasses({super.key});

  @override
  State<StatefulWidget> createState() => _MyClasses();
}

class _MyClasses extends State<MyClasses>{
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        getClassCard(
            courseTitle: "Scientific Research and Methodology",
            courseCode: "CSE-466",
            classDate: "Tuesday",
            classTime: "7:00 - 8:00",
            backgroundColor: Colors.redAccent
        ),
        getClassCard(
            courseTitle: "Wireless Networks",
            courseCode: "CSE-431",
            classDate: "Sunday",
            classTime: "7:00 - 9:00",
            backgroundColor: Colors.green
        ),
        getClassCard(
            courseTitle: "Machine Learning",
            courseCode: "CSE-321",
            classDate: "Monday",
            classTime: "04:50 - 7:00",
            backgroundColor: Colors.deepPurple
        ),
        getClassCard(
            courseTitle: "Machine Learning Lab",
            courseCode: "CSE-322",
            classDate: "Thursday",
            classTime: "7:00 - 8:00",
            backgroundColor: Colors.blue
        ),
        getClassCard(
            courseTitle: "Wireless Network Lab",
            courseCode: "CSE-433",
            classDate: "Thursday",
            classTime: "8:00 - 9:00",
            backgroundColor: Colors.teal
        )
      ],
    );
  }

  Widget getClassCard({courseTitle, courseCode, classDate, classTime, backgroundColor}){
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.deepPurple
        ),
        onPressed: (){},
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$courseCode - $courseTitle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date", style: TextStyle(color: Colors.white)),
                          Text(classDate, style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Period", style: TextStyle(color: Colors.white),),
                          Text(classTime, style: TextStyle(color: Colors.white))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}