class AcademicYearModel {
  AcademicYearModel({
    required this.academicYearId,
    required this.academicYearName,
  });

  int academicYearId;
  String academicYearName;

  factory AcademicYearModel.fromJson(Map<String, dynamic> json) => AcademicYearModel(
    academicYearId: json["academicYearId"],
    academicYearName: json["academicYearName"],
  );

  Map<String, dynamic> toJson() => {
    "academicYearId": academicYearId,
    "academicYearName": academicYearName,
  };
}