import 'package:intl/intl.dart';

class AnnouncementModel{
  int announcementId;
  String content;
  int commentsCount;
  String time;
  int userId;
  String fullName;
  String userType;
  String username;
  String? photo;

  AnnouncementModel({
    required this.announcementId,
    required this.content,
    required this.commentsCount,
    required this.username,
    required this.fullName,
    required this.time,
    required this.userId,
    required this.userType,
    this.photo
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json){
    return AnnouncementModel(
        announcementId: json['announcementId'],
        content: json['content'],
        commentsCount: json['commentsCount'],
        username: json['username'],
        fullName: json['fullName'],
        time: DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(json['time'])),
        userId: json['userId'],
        userType: json['userType'],
        photo: json['photo']
    );
  }

}