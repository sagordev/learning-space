import 'package:intl/intl.dart';

class NoticeModel{
  final int id;
  final String date;
  final String title;
  final String link;
  final String content;

  NoticeModel({
    required this.id,
    required this.date,
    required this.title,
    required this.link,
    required this.content
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json){
    String date = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(json['date']));
    return NoticeModel(
        id: json['id'],
        date: date,
        title: json['title']['rendered'],
        link: json['link'],
        content: json['content']['rendered']
    );
  }
}