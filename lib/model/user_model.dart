class UserModel{
  final int userId;
  final String username;
  final String fullName;
  final String type;
  final String photo;
  final String phoneNumber;

  UserModel({
    required this.fullName,
    required this.userId,
    required this.username,
    required this.photo,
    required this.type,
    required this.phoneNumber
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(fullName: json['fullName'],
        userId: json['userId'],
        username: json['username'],
        photo: json['photo'] ?? '',
        type: json['type'],
        phoneNumber: json['phoneNumber'] ?? ''
    );
  }
}