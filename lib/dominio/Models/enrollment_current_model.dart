class EnrollmentCurrentModel {
  EnrollmentCurrentModel({
    required this.id,
    required this.personId,
    required this.sectionId,
    required this.sectionName,
    required this.gradeName,
    required this.levelName,
    required this.statusEnrollment,
  });

  int id;
  int personId;
  int sectionId;
  String sectionName;
  String gradeName;
  String levelName;
  String statusEnrollment;

  factory EnrollmentCurrentModel.fromJson(Map<String, dynamic> json) => EnrollmentCurrentModel(
    id: json["id"],
    personId: json["personId"],
    sectionId: json["sectionId"],
    sectionName: json["sectionName"],
    gradeName: json["gradeName"],
    levelName: json["levelName"],
    statusEnrollment: json["statusEnrollment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "personId": personId,
    "sectionId": sectionId,
    "sectionName": sectionName,
    "gradeName": gradeName,
    "levelName": levelName,
    "statusEnrollment": statusEnrollment,
  };
}