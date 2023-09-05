import 'package:flutter/material.dart';
import 'package:learning_space/model/class_model.dart';
import 'package:learning_space/services/class_service.dart';

class Routine extends StatefulWidget {
  const Routine({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _Routine();
}

class _Routine extends State<Routine>{
  late Future<List<ClassModel>> allClasses;

  @override
  void initState() {
    allClasses = ClassService().getMyClasses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: FutureBuilder(
                future: allClasses,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(child: Text("${snapshot.data![index].courseCode}")),
                            Expanded(child: Text("${snapshot.data![index].classDay}")),
                            Expanded(child: Text("${snapshot.data![index].classTime}"))
                          ],
                        );
                      },
                    );
                  } else if(snapshot.hasError){
                    return Text("Failed to get data...");
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
            ),
        )
    );
  }
}
