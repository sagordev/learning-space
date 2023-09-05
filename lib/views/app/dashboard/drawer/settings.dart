import 'package:flutter/material.dart';
import 'package:learning_space/services/class_service.dart';

class Settings extends StatefulWidget{
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() => _Settings();
}

class _Settings extends State<Settings>{
  late Future settingsData;

  @override
  void initState() {
    // TODO: implement initState
    settingsData = ClassService().getSettings();
  }

  updateSettings(String key, dynamic value) async {
    await ClassService().updateSettings(key, value);
    setState(() {
      settingsData = ClassService().getSettings();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: FutureBuilder(
        future: settingsData,
        builder: (_, snapshot) {
          if(snapshot.hasData){
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone number visibility", style: TextStyle(fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      Expanded(
                          child: Text("Visible to students")
                      ),
                      Expanded(
                          child: Switch(
                            onChanged: (val){
                              updateSettings("NUMBER_VISIBLE_TO_STUDENT", val ? 'yes' : 'no');
                            },
                            value: snapshot.data['NUMBER_VISIBLE_TO_STUDENT'] == 'no' ? false : true,
                          )
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text("Visible to teachers")
                      ),
                      Expanded(
                          child: Switch(
                            onChanged: (val){
                              updateSettings("NUMBER_VISIBLE_TO_TEACHER", val ? 'yes' : 'no');
                            },
                            value: snapshot.data['NUMBER_VISIBLE_TO_TEACHER'] == 'no' ? false : true,
                          )
                      )
                    ],
                  )
                ],
              ),
            );
          }else if(snapshot.hasError){
            return Text("failed to load settings");
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

}