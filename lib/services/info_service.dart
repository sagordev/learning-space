import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:learning_space/model/notice_model.dart';

class InfoService{
  Future<List<NoticeModel>> getNotices() async {
    String url = "https://uits.edu.bd/wp-json/wp/v2/posts";
    try{
      final response = await Dio()
          .get(url, options: Options(
        headers:  {
          'Content-Type': 'application/json'
        }
      ));
      List<dynamic> noticeList = response.data;
      List<NoticeModel> notices = noticeList.map((e) => NoticeModel.fromJson(e)).toList();
      return notices;
    }catch(e, st){
      print(e);
      print(st);
    }
    return [];
  }
}