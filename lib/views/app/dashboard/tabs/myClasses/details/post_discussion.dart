import 'package:flutter/material.dart';

class PostDiscussion extends StatefulWidget{
  const PostDiscussion({super.key, required this.color});
  final Color color;
  @override
  State<StatefulWidget> createState() => _PostDiscussion();
}

class _PostDiscussion extends State<PostDiscussion>{
  final formKey = GlobalKey<FormState>();
  late String text;
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
                      TextSpan(text: "CSE-431 - Machine Learning", style: TextStyle(fontWeight: FontWeight.bold))
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
                    print(this.text);
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