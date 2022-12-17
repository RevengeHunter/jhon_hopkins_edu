import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jhon_hopkins_edu/dominio/Models/enrollment_current_model.dart';
import 'package:jhon_hopkins_edu/dominio/Models/enrollment_with_course_model.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';

import '../../Utils/constant.dart';

class EnrollmentService {
  final SPGlobal _prefs = SPGlobal();

  Future<int> getEnrollmentPerson() async {
    Uri url = Uri.parse('$path/EnrollmentPerson/${_prefs.idPerson}');
    http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'text/plain',
        'Authorization': 'bearer ${_prefs.jwt}',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = jsonDecode(response.body);
      List myList = myMap["data"];
      int idEnrollment = myList.first;
      return idEnrollment;
    }

    return 0;
  }

  Future<EnrollmentCurrentModel?> getCurrentEnrollmentByStudent() async {
    Uri url = Uri.parse('$path/Enrollment/GetCurrentEnrollmentByStudent');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${_prefs.jwt}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'personId': _prefs.idPerson,
        },
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = jsonDecode(response.body);
      if(!myMap["succeeded"]) return null;
      EnrollmentCurrentModel enrollmentCurrentModel =
          EnrollmentCurrentModel.fromJson(myMap["data"]);
      return enrollmentCurrentModel;
    }

    return null;
  }

  Future<List<EnrollmentWithCourseModel>>
      getEnrollmentWithCourseByAcademicPeriod(int idAcademicPeriod) async {
    Uri url = Uri.parse('$path/Enrollment/listCourse');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${_prefs.jwt}',
      },
      body: jsonEncode(
          idAcademicPeriod
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = jsonDecode(response.body);
      List myList = myMap["data"];
      List<EnrollmentWithCourseModel> enrollmentCurrentModelList =
          myList.map((e) => EnrollmentWithCourseModel.fromJson(e)).toList();
      return enrollmentCurrentModelList;
    }

    return [];
  }
}
