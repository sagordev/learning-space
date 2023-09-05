import 'package:flutter/material.dart';
import 'package:learning_space/model/user_model.dart';
import 'package:learning_space/services/class_service.dart';
import 'package:learning_space/views/shared/avatar.dart';

class Participants extends StatefulWidget{
  final int classId;
  const Participants({super.key, required this.classId});

  @override
  State<StatefulWidget> createState() => _Participants();
}

class _Participants extends State<Participants>{
  late Future<List<UserModel>> participants;

  @override
  void initState() {
    participants = ClassService().getParticipants(widget.classId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: participants,
      builder: (_, snapshot){
        if(snapshot.hasData){
          List<UserModel> teachers = [];
          List<UserModel> students = [];
          snapshot.data!.forEach((user) {
            if(user.type.toLowerCase() == 'teacher'){
              teachers.add(user);
            }else{
              students.add(user);
            }
          });

          return Column(
            children: [
              getUsers('Teachers', teachers),
              getUsers('Students', students),
            ],
          );
        }else if(snapshot.hasError){
          Text(snapshot.error.toString());
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }


  Widget getUsers(title, List<UserModel> data){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width,
          child: Text("$title (${data.length})", style: TextStyle(fontSize: 20),),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
          ),
        ),
        data.length == 0 ?
           Text("No ${title} Assigend")
        :
        ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: (_, index){
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Avatar(photo: data[index].photo,),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data[index].fullName, style: TextStyle(fontWeight: FontWeight.bold),),
                      RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(text: data[index].username),
                              TextSpan(text: " • "),
                              TextSpan(text: data[index].phoneNumber)
                            ]
                          ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        )
      ]
    );
  }

}