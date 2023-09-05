import 'package:flutter/material.dart';
import 'package:learning_space/model/notice_model.dart';
import 'package:learning_space/services/info_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Notice extends StatefulWidget {
  const Notice({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _Notice();
}

class _Notice extends State<Notice>{
  late Future<List<NoticeModel>> notices;
  @override
  initState(){
    _getNotices();
    super.initState();
  }

  _getNotices() async {
    Future<List<NoticeModel>> n = InfoService().getNotices();
    setState(() {
      notices = n;
    });
    return n;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
        padding: EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh: () => _getNotices() ,
          child: FutureBuilder(
            future: notices,
            builder: (_, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data!.length,

                    itemBuilder: (_, index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(0),
                            ),
                            onPressed: (){
                              _launchUrl(snapshot.data![index].link);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].title, style: TextStyle(color: Colors.black),),
                                  Text(snapshot.data![index].date, style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Divider()
                        ],
                      );
                    }
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        )
      )
    );
  }

  Future<void> _launchUrl(url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication,)) {
      //
    }
  }
}
