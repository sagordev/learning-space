class ClassModel{
  ClassModel({
    required this.classId,
    required this.classCode,
    required this.courseCode,
    required this.courseTitle,
    this.classDay,
    this.classTime
  });

  int classId;
  String classCode;
  String courseCode;
  String courseTitle;
  String? classDay;
  String? classTime;

  factory ClassModel.fromJson(Map<String, dynamic> json){
    return ClassModel(
        classId: json['classId'],
        classCode: json['classCode'],
        courseCode: json['courseCode'],
        courseTitle: json['courseTitle'],
        classDay: json['classDay'] ?? '',
        classTime: json['classTime'] ?? ''
    );
  }
}