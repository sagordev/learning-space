import 'package:flutter/material.dart';
import 'package:learning_space/model/announcement_model.dart';
import 'package:learning_space/services/auth_service.dart';
import 'package:learning_space/services/class_service.dart';
import 'package:learning_space/views/app/dashboard/tabs/myClasses/details/post_discussion.dart';
import 'package:learning_space/views/shared/avatar.dart';

import 'package:learning_space/model/comments.dart';

class Discussion extends StatefulWidget{
  final int classId;
  final Color color;
  final String title;
  const Discussion({super.key, required this.classId, required this.title, required this.color});
  @override
  State<StatefulWidget> createState() => _Discussion();
}

class _Discussion extends State<Discussion>{
  late Future<List<AnnouncementModel>> announcements;
  Map<String, dynamic> userDetails = {};
  @override
  void initState() {
    _getAnnouncement();
    () async {
      final ud = await AuthService().getDecodedToken();
      setState(() {
        userDetails = ud['claims'];
      });
    }();
    super.initState();
  }



  _getAnnouncement(){
    Future<List<AnnouncementModel>> data = ClassService().getAnnouncements(widget.classId);
    setState(() {
      announcements = data;
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: TextStyle(fontSize: 15, color: Colors.black),
        child: RefreshIndicator(
          onRefresh: () => _getAnnouncement(),
          child: Column(
            children: [
              FutureBuilder(
                future: announcements,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Expanded(
                        child: ListView.builder(
                            itemCount: (snapshot.data?.length ?? 0) + 1,
                            itemBuilder: (context, index){
                              if(index == 0){
                                return getAnnouncementPostOption();
                              }
                              int index_ = index - 1;
                              return getSingleDiscussion(
                                  announcementId: snapshot.data![index_].announcementId,
                                  author: snapshot.data![index_].fullName,
                                  time: snapshot.data![index_].time,
                                  content: snapshot.data![index_].content,
                                  commentsCount: snapshot.data![index_].commentsCount,
                                  type: snapshot.data![index_].userType,
                                  username: snapshot.data![index_].username,
                                  photo: snapshot.data![index_].photo
                              );
                            }
                        )
                    );
                  }else if(snapshot.hasError){
                    return Center(child: Text("Something went wrong"),);
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          )
        )
    );
  }


  Widget getSingleDiscussion({
    announcementId,
    author,
    time,
    content,
    commentsCount,
    type,
    username,
    photo
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
                Avatar(photo: photo,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(" $author", style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Row(
                          children: [
                            Text(type == "teacher" ? "Teacher" : username, style: TextStyle(color: Colors.grey)),
                            Text(" • "),
                            Text("$time", style: TextStyle(color: Colors.grey),),
                          ],
                        ),
                    )

                  ],
                ),
              ],
            ),

            Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(content),
                    Divider(),
                    SizedBox(
                      height: 25,
                      child: GestureDetector(
                          onTap: (){
                            _openComments(announcementId: announcementId);
                          },
                          // style: TextButton.styleFrom(
                          //   padding: EdgeInsets.all(0),
                          // ),
                          child: Text("${commentsCount} Comments", style: TextStyle(
                            color: Colors.grey
                          ),)
                      ),
                    ),
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
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: TextButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostDiscussion(
                classId: widget.classId, color: widget.color, title: widget.title))).then((_){
                  _getAnnouncement();
            });
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(0),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Color(0xFFDFDFDF)),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              children: [
                Avatar(photo: userDetails?['photo'],),
                Text(" Announce something to your class...", style: TextStyle(color: Colors.grey),)
              ],
            ),
          )
      )
    ));
  }

  _openComments({announcementId}){
    var txt = TextEditingController();
    String? comment;
    bool isCommentPosting = false;
    late Future<List<Comments>> allComments;
    getComments() async {
      Future<List<Comments>> ac = ClassService().getAnnouncementComments(announcementId);
      setState(() {
        allComments = ac;
      });
      return ac;
    }
    getComments();

    onCreateComment() async {
      if(comment == null || comment == ''){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.red,
                content: Text("Please write something")
            )
        );
        return;
      }
      try{
        dynamic resp = await ClassService().createComment(announcementId, '${comment}');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: resp['success'] ? Colors.green : Colors.red,
                content: Text(resp['message'])
            )
        );
        if(resp['success']){
          txt.text = '';
        }
      }catch(e, st){
        print(st);
      }
    }

    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            child: StatefulBuilder(
              builder:(_, setState) => Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: allComments,
                    builder: (_, snapshot){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Comments"),
                          Divider(),
                          Container(
                            child: snapshot.hasData ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index){
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                            TextSpan(text: "${snapshot.data![index].fullName} ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                            TextSpan(text: "${snapshot.data![index].comment} ")
                                          ]
                                      )
                                  ),
                                );
                              }
                            ): snapshot.hasError
                                ? Text("Error")
                                : Center(child: CircularProgressIndicator(),)
                          ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    comment = value;
                                  });
                                },
                                controller: txt,
                                decoration: InputDecoration(
                                    hintText: "Enter your comment.",
                                ),
                              )),
                              GestureDetector(
                                onTap: () async {
                                  setState((){
                                    isCommentPosting = true;
                                  });
                                  await onCreateComment();
                                  setState((){
                                    allComments = getComments();
                                    comment = '';
                                    isCommentPosting = false;
                                  });
                                },
                                child: isCommentPosting ? CircularProgressIndicator() : Icon(Icons.send),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            )
          );
        }
    );
  }
}