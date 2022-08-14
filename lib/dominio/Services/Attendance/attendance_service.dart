import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';

import '../../Models/attendance_model.dart';
import '../../Utils/constant.dart';

class AttendanceService {
  final SPGlobal _prefs = SPGlobal();

  Future<List<AttendanceModel>> getAttendance(int idAcademicYear,String documentNumber) async {
    Uri url = Uri.parse('$path/Assistance/GetAssistanceByStudentDocumentNumber');
    http.Response response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${_prefs.jwt}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'academicYearId': idAcademicYear,
          'documentNumber': documentNumber,
        },
      ),
    );

    if(response.statusCode == 200){
      Map<String, dynamic> myMap = jsonDecode(response.body);
      List myList = myMap["data"];
      List<AttendanceModel> attendanceList = myList.map((e) => AttendanceModel.fromJson(e)).toList();
      return attendanceList;
    }

    return [];
  }
}