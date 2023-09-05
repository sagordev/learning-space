import 'dart:convert';

import 'package:learning_space/configs/endpoints.dart';
import 'package:learning_space/model/announcement_model.dart';
import 'package:learning_space/model/class_model.dart';
import 'package:learning_space/model/comments.dart';
import 'package:learning_space/model/user_model.dart';
import 'package:learning_space/services/api_service.dart';
import 'package:learning_space/views/app/dashboard/tabs/myClasses/my_classes.dart';

class ClassService {
  Future<List<ClassModel>> getMyClasses() async {
    final response = await ApiService().dio.get(Endpoints.MY_CLASSES);
    if(response.statusCode == 200 && response.data['success']){
      List<dynamic> listClass = response.data['data'];
      List<ClassModel> classes = listClass.map((d) => ClassModel.fromJson(d)).toList();
      return classes;
    }else{
      throw Exception("Failed to fetch data");
    }
  }

  Future<List<AnnouncementModel>> getAnnouncements(int classId) async {
    final response = await ApiService().dio.get(Endpoints.ANNOUNCEMENTS, queryParameters: {
      'classId': classId.toString()
    });
    if(response.statusCode == 200 && response.data['success']){
      try{
        List<dynamic> listAnnouncement = response.data['data'];
        List<AnnouncementModel> announcement = listAnnouncement.map((e) => AnnouncementModel.fromJson(e)).toList();
        return announcement;
      }catch(e,stacktrace){
        print(e);
        print(stacktrace);
      }
    }
    throw Exception("Failed to fetch data");
  }

  Future postAnnouncement(int classId, String content) async {
    final response = await ApiService().dio.post(Endpoints.POST_ANNOUNCEMENT, data: {
      'classId': classId,
      'content': content
    });
    return response.data;
  }

  Future<List<UserModel>> getParticipants(int classId) async {
    final response = await ApiService().dio.get(Endpoints.CLASS_PARTICIPANTS, queryParameters: {
      'classId': classId
    });
    List<dynamic> listUser = response.data['data'];
    List<UserModel> users = listUser.map((e) => UserModel.fromJson(e)).toList();
    return users;
  }

  Future joinClass(String classCode) async {
    final response = await ApiService().dio.post(Endpoints.JOIN_CLASS, data: {
      'classCode': classCode,
    });
    return response.data;
  }


  Future createClass(Map<String, dynamic> params) async {
    final response = await ApiService().dio.post(Endpoints.CREATE_CLASS, data: params);
    return response.data;
  }

  Future<List<Comments>> getAnnouncementComments(int announcementId) async {
    final response = await ApiService().dio.get(Endpoints.ANNOUNCEMENTS_COMMENTS, queryParameters: {
      'announcementId': announcementId
    });
    List<dynamic> listUser = response.data['data'];
    List<Comments> comments = listUser.map((e) => Comments.fromJson(e)).toList();
    return comments;
  }

  Future createComment(int announcementId, String comment) async {
    final response = await ApiService().dio.post(Endpoints.CREATE_COMMENT, data: {
      "announcementId": announcementId,
      "comment": comment
    });
    return response.data;
  }

  Future getSettings() async {
    final response = await ApiService().dio.get(Endpoints.GET_SETTINGS);
    final listUser = response.data['data'];
    return listUser;
  }

  Future updateSettings(String key, dynamic value) async {
    final response = await ApiService().dio.post(Endpoints.UPDATE_SETTINGS, data: {
      "name": key,
      "value": value
    });
    return response.data;
  }
}