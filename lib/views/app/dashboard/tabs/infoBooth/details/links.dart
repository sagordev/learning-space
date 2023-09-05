import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Links extends StatefulWidget {
  const Links({super.key, required this.title});
  final String title;
  @override
  State<StatefulWidget> createState() => _Links();
}

class _Links extends State<Links>{
  List<Map<String, dynamic>> allLinks = [{
    "name": "UITS Website",
    "link": "https://uits.edu.bd/"
  },
    {
    "name": "UITS Alumni Association",
    "link": "https://alumni.uits.edu.bd"
  },
    {
      "name": "University Grants Commission",
      "link": "http://www.ugc.gov.bd"
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: allLinks.length,
                itemBuilder: (context, index){
                  return ListTile(
                    onTap: (){
                      _launchUrl(allLinks[index]['link']);
                    },
                    leading: Icon(Icons.link),
                    title: Text(allLinks[index]['name']),
                  );
                }
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
