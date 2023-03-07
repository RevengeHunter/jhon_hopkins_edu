class AttendanceModel {
  AttendanceModel({
    required this.courseName,
    required this.total,
    required this.quantityAttended,
    required this.quantityAbsent,
    required this.quantityLicense,
    required this.quantityJustify,
    this.details,
  });

  String courseName;
  int total;
  int quantityAttended;
  int quantityAbsent;
  int quantityLicense;
  int quantityJustify;
  List<Detail>? details;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
    courseName: json["courseName"],
    total: json["total"],
    quantityAttended: json["quantityAttended"],
    quantityAbsent: json["quantityAbsent"],
    quantityLicense: json["quantityLicense"],
    quantityJustify: json["quantityJustify"],
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "courseName": courseName,
    "total": total,
    "quantityAttended": quantityAttended,
    "quantityAbsent": quantityAbsent,
    "quantityLicense": quantityLicense,
    "quantityJustify": quantityJustify,
    "details": List<dynamic>.from(details??[].map((x) => x.toJson())),
  };

  double getAttendancePorcentage(){
    double attendancePercentage = ((quantityAttended * 100) / total);
    return attendancePercentage;
  }
}

class Detail {
  Detail({
    this.assistanceType,
    this.assistanceDate,
  });

  int? assistanceType;
  DateTime? assistanceDate;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    assistanceType: json["assistanceType"],
    assistanceDate: DateTime.parse(json["assistanceDate"]),
  );

  Map<String, dynamic> toJson() => {
    "assistanceType": assistanceType??0,
    "assistanceDate": assistanceDate??"2022-08-12T20:35:55.022Z",
  };
}
