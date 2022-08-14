class EnrollmentPersonModel {
  EnrollmentPersonModel({
    required this.id,
    required this.personId,
    required this.sectionId,
    required this.statusEnrollment,
  });

  int id;
  int personId;
  int sectionId;
  String statusEnrollment;

  factory EnrollmentPersonModel.fromJson(Map<String, dynamic> json) => EnrollmentPersonModel(
    id: json["id"],
    personId: json["personId"],
    sectionId: json["sectionId"],
    statusEnrollment: json["statusEnrollment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "personId": personId,
    "sectionId": sectionId,
    "statusEnrollment": statusEnrollment,
  };
}