import 'package:flutter/material.dart';

class Discussion extends StatefulWidget{
  const Discussion({super.key});
  @override
  State<StatefulWidget> createState() => _Discussion();
}

class _Discussion extends State<Discussion>{
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: TextStyle(fontSize: 15, color: Colors.black),
        child: ListView(
          children: [
            getAnnouncementPostOption(),
            getSingleDiscussion(
              author: "Mrinmoy Biswas Akash",
              time: "Jul 8, 2023",
              content: "Hello everyone.We have a presentation due, when do you want to do it? Let's do it fast, as we need to publish the result.You can submit the presentation in two ways:1. Live online presentation with me. In this case, give me a time when you can do it.2. Make a video of you presenting your slides with voiceover and recorded-screen and send it to me. My email address is mrinmoy.biswas@uits.edu.bd, in the subject field write SRM-Presentation and add your name and roll number with the mail.Thank you."
            ),
            getSingleDiscussion(
                author: "Afsana Akter",
                time: "Jul 7, 2023",
                content: "Dear Sir, Could you please post the reference book here?"
            ),
            getSingleDiscussion(
                author: "Md. Asadujjaman Sagor",
                time: "Jul 6, 2023",
                content: "Sir, We need a make up class, I think we can arrange it next sunday at 7:00pm. All of my batchmates are OK with that time."
            )
          ],
        )
    );
  }


  Widget getSingleDiscussion({
    author,
    time,
    content
  }){
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1, color: Color(0xFFdadce0)),
            color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(child: Icon(Icons.person, color: Colors.grey,),backgroundColor: Color(0xFFDFDFDF),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(" $author", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(" $time", style: TextStyle(color: Colors.grey),)
                  ],
                ),
              ],
            ),

            Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(content),
                    Divider(),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Color(0xFFdadce0)),
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          width: MediaQuery.of(context).size.width - 80,
                          child: Text("Write your comment here", style: TextStyle(color: Colors.grey),),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.send, color: Color(0xFFdadce0),)
                      ],
                    )
                  ],
                )
            )
          ],
        )
    );
  }

  Widget getAnnouncementPostOption(){
    return Padding(padding: EdgeInsets.only(bottom: 10),
      child: TextButton(
          onPressed: (){},
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(0),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              children: [
                CircleAvatar(child: Icon(Icons.person, color: Colors.grey,),backgroundColor: Color(0xFFDFDFDF),),
                Text(" Announce something to your class...", style: TextStyle(color: Colors.grey),)
              ],
            ),
          )
      )
    );
  }
}