class Comments{
  final int commentId;
  final String comment;
  final int announcementId;
  final int userId;
  final String fullName;
  final String? photo;

  Comments({
    required this.commentId,
    required this.comment,
    required this.announcementId,
    required this.userId,
    required this.fullName,
    this.photo
  });

  factory Comments.fromJson(Map<String, dynamic> json){
    return Comments(
      commentId: json['commentId'],
      comment: json['comment'],
      announcementId: json['announcementId'],
      userId: json['userId'],
      fullName: json['fullName'],
      photo: json['photo']
    );
  }
}