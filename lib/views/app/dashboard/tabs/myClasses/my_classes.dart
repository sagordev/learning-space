import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_space/model/class_model.dart';
import 'package:learning_space/services/auth_service.dart';
import 'package:learning_space/services/class_service.dart';
import 'package:learning_space/utils/random_color.dart';
import 'package:learning_space/views/app/dashboard/tabs/myClasses/details/details.dart';

class MyClasses extends StatefulWidget{
  const MyClasses({super.key});

  @override
  State<StatefulWidget> createState() => _MyClasses();
}

class _MyClasses extends State<MyClasses>{
  bool isJoining = false;
  final formKey = GlobalKey<FormState>();
  String? classCode;
  // For create
  String? courseCode;
  String? courseTitle;
  String? classDay;
  String? classTime;

  Map<String, dynamic> tokenDetails = {};

  late Future<List<ClassModel>> allClasses;
  @override
  void initState() {
    allClasses = ClassService().getMyClasses();
    _getTokenDetails();
    super.initState();
  }

  _getTokenDetails()async{
    dynamic td = await AuthService().getDecodedToken();
    print(td["claims"]['type']);

    if(td != null || td!= false){
      setState(() {
        tokenDetails = td["claims"];
      });
    }
  }

  _onJoinClass() async {

    onClick() async {
      if(formKey.currentState!.validate()){
        formKey.currentState!.save();
        bool isSuccess = false;
        String message = "";
        try{
          final response = await ClassService().joinClass('$classCode');
          isSuccess = response['success'];
          message = response['message'];
        }catch(e, st){
          message = "Something went wrong!";
        }
        if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: isSuccess ? Colors.green : Colors.red,
                  content: Text(message)
              )
          );
        }

        if(isSuccess == true){
          final fetchAllClasses = ClassService().getMyClasses();
          setState(() {
            allClasses = fetchAllClasses;
          });
          await fetchAllClasses;
          if(context.mounted){
            Navigator.of(context).pop();
          }
        }
      }
    }
    showDialog(
        context: context,
        builder: (_){
          return Dialog(
            child: StatefulBuilder(
              builder: (_, setState){
                return IntrinsicHeight(
                  child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Join", style: TextStyle(fontSize: 19),),
                            Divider(),
                            TextFormField(
                              decoration: const InputDecoration(
                                label: Text("Class Code"),
                                hintText: "Enter Class Code",
                              ),
                              validator: (value){
                                return value == null || value.length < 4 ? 'Enter valid class code' : null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  classCode = value;
                                });
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: ElevatedButton(
                                        onPressed: isJoining ? null : () async {
                                          setState(() {
                                            isJoining = true;
                                          });
                                          await onClick();
                                          setState(() {
                                            isJoining = false;
                                          });
                                        },
                                        child: Text(isJoining ? "Joining..." : "Join")
                                    )
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ),
                );
              },
            )
          );
        }
    );
  }

  _onCreateClass() async {

    onClick() async {
      if(formKey.currentState!.validate()){
        formKey.currentState!.save();
        bool isSuccess = false;
        String message = "";
        try{
          Map<String, dynamic> params = {
            "courseCode": courseCode,
            "courseTitle": courseTitle,
            "classDay": classDay,
            "classTime": classTime
          };

          final response = await ClassService().createClass(params);
          isSuccess = response['success'];
          message = response['message'];
        }catch(e, st){
          message = "Something went worng!";
        }
        if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: isSuccess ? Colors.green : Colors.red,
                  content: Text(message)
              )
          );
        }

        if(isSuccess == true){
          final fetchAllClasses = ClassService().getMyClasses();
          setState(() {
            allClasses = fetchAllClasses;
          });
          await fetchAllClasses;
          if(context.mounted){
            Navigator.of(context).pop();
          }
        }
      }
    }
    showDialog(
        context: context,
        builder: (_){
          return Dialog(
              child: StatefulBuilder(
                builder: (_, setState){
                  return IntrinsicHeight(
                    child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Create Class", style: TextStyle(fontSize: 19),),
                              Divider(),
                              TextFormField(
                                decoration: const InputDecoration(
                                  label: Text("Course Code*"),
                                ),
                                validator: (value){
                                  return value == null || value.length < 3 ? 'Enter valid course code' : null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    courseCode = value;
                                  });
                                },
                              ),
                              SizedBox(height: 5,),
                              TextFormField(
                                decoration: const InputDecoration(
                                  label: Text("Course Title*"),
                                ),
                                validator: (value){
                                  return value == null || value.length < 3 ? 'Enter valid course title' : null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    courseTitle = value;
                                  });
                                },
                              ),
                              SizedBox(height: 5,),
                              TextFormField(
                                decoration: const InputDecoration(
                                  label: Text("Class Day"),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    classDay = value;
                                  });
                                },
                              ),
                              SizedBox(height: 5,),
                              TextFormField(
                                decoration: const InputDecoration(
                                  label: Text("Class Time"),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    classTime = value;
                                  });
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                          onPressed: isJoining ? null : () async {
                                            setState(() {
                                              isJoining = true;
                                            });
                                            await onClick();
                                            setState(() {
                                              isJoining = false;
                                            });
                                          },
                                          child: Text(isJoining ? "Creating..." : "Create")
                                      )
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                    ),
                  );
                },
              )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            tokenDetails['type'] == 'teacher' ?
            Expanded(
              child: ElevatedButton(
                  onPressed: () async {
                    await _onCreateClass();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_box_rounded),
                      Text("Create Class")
                    ],
                  )
              ),
            ): SizedBox(),

            SizedBox(
              width: tokenDetails['type'] == 'teacher' ? 5 : 0,
            ),
            Expanded(
                child: ElevatedButton(
                    onPressed: () async {
                      await _onJoinClass();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.handshake_rounded),
                        Text("Join Class")
                      ],
                    )
                ),
            )
          ],
        ),
        Expanded(
          child: FutureBuilder(
              future: allClasses,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return getClassCard(
                          classId: snapshot.data![index].classId,
                          classCode: snapshot.data![index].classCode,
                          courseTitle: snapshot.data![index].courseTitle,
                          courseCode: snapshot.data![index].courseCode,
                          classDate: snapshot.data![index].classDay,
                          classTime: snapshot.data![index].classTime,
                          backgroundColor: RandomColor.getRandomColor(index)
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
      ],
    );

  }

  Widget getClassCard({required int classId, classCode, courseTitle, courseCode, classDate, classTime, backgroundColor}){
    final Color bgcolor = backgroundColor ?? Colors.deepPurple;
    final String title = '$courseCode - $courseTitle';
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.deepPurple,
          padding: EdgeInsets.all(0)
        ),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(classId: classId, title: title, color: bgcolor)));
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: Container(
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage('assets/images/classbg.png'),
              //   alignment: Alignment.topRight,
              //   scale: 1.5
              // )
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Code", style: TextStyle(color: Colors.white)),
                          Text(classCode, style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Day", style: TextStyle(color: Colors.white)),
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