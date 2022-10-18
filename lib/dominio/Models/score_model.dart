class ScoreModel {
  ScoreModel({
    required this.academicYearId,
    required this.personId,
    required this.personName,
    required this.bimesterId,
    required this.bimesterName,
    required this.courseId,
    required this.courseName,
    required this.levelId,
    required this.consolidationScoreValue,
  });

  int academicYearId;
  int personId;
  String personName;
  int bimesterId;
  String bimesterName;
  int courseId;
  String courseName;
  int levelId;
  double consolidationScoreValue;

  factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
    academicYearId: json["academicYearId"],
    personId: json["personId"],
    personName: json["personName"],
    bimesterId: json["bimesterId"],
    bimesterName: json["bimesterName"],
    courseId: json["courseId"],
    courseName: json["courseName"],
    levelId: json["levelId"],
    consolidationScoreValue: json["consolidationScoreValue"],
  );

  Map<String, dynamic> toJson() => {
    "academicYearId": academicYearId,
    "personId": personId,
    "personName": personName,
    "bimesterId": bimesterId,
    "bimesterName": bimesterName,
    "courseId": courseId,
    "courseName": courseName,
    "levelId": levelId,
    "consolidationScoreValue": consolidationScoreValue,
  };
}