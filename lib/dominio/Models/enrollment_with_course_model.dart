class EnrollmentWithCourseModel {
  EnrollmentWithCourseModel({
    required this.courseId,
    required this.courseName,
  });

  int courseId;
  String courseName;

  factory EnrollmentWithCourseModel.fromJson(Map<String, dynamic> json) => EnrollmentWithCourseModel(
    courseId: json["courseId"],
    courseName: json["courseName"],
  );

  Map<String, dynamic> toJson() => {
    "courseId": courseId,
    "courseName": courseName,
  };
}