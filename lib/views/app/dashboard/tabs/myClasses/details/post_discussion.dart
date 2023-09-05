import 'package:flutter/material.dart';
import 'package:learning_space/services/class_service.dart';

class PostDiscussion extends StatefulWidget{
  const PostDiscussion({super.key, required this.classId, required this.title, required this.color});
  final int classId;
  final Color color;
  final String title;
  @override
  State<StatefulWidget> createState() => _PostDiscussion();
}

class _PostDiscussion extends State<PostDiscussion>{
  final formKey = GlobalKey<FormState>();
  late String text;

  submit() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_){
          return Dialog(
            child: SizedBox(
              height: 120,
              child:  Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 15,),
                  Text("Please wait...")
                ],
              ),
            )
          );
        }
    );
    try{
      dynamic resp = await ClassService().postAnnouncement(widget.classId, this.text);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: resp['success'] ? Colors.green : Colors.red,
              content: Text(resp['message'])
          )
      );
    }catch(e, st){
      print(st);
    }
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Announcement"),
        backgroundColor: widget.color,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Color(0xFFDFDFDF)),
          ),
          child: Column(
            children: [
              RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: "Post an announcement to "),
                      TextSpan(text: widget.title, style: TextStyle(fontWeight: FontWeight.bold))
                    ]
                  ),
              ),
              SizedBox(height: 10,),
              Form(
                key: formKey,
                child: getForm(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getForm(){
    return Expanded(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                minLines: 8,
                maxLines: 12,
                decoration: InputDecoration(
                  hintText: "Write here something..."
                ),
                validator: (String? value){
                  return (value != null && value.trim().length < 1 ? 'Write Something First' : null);
                },
                onChanged: (val) => {
                  setState((){
                    text = val;
                  })
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed:  ()async{
                      Navigator.of(context).pop();
                    }, child: Text("CANCEL"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey
                    ),
                  ),
                  SizedBox(width: 5,),
                  ElevatedButton(onPressed: formKey.currentState != null && formKey.currentState!.validate() ? (){
                    formKey.currentState!.save();
                    submit();
                  } : null,

                      child: Row(
                        children: [
                          Icon(Icons.send),
                          Text("POST")
                        ],
                      )
                  )
                ],
              )
            ]
        )
    );
  }
}