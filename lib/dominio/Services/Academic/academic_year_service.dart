import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jhon_hopkins_edu/dominio/Models/academic_year_model.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';

import '../../Utils/constant.dart';

class AcademicYearService {
  final SPGlobal _prefs = SPGlobal();

  Future<List<AcademicYearModel>> getAcademicYearList(
      String documentNumber) async {
    Uri url = Uri.parse('$path/AcademicYear/GetByStudent');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${_prefs.jwt}',
      },
      body: jsonEncode(
        <String, String>{
          'documentNumber': documentNumber,
        },
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = jsonDecode(response.body);
      List myList = myMap["data"];

      List<AcademicYearModel> academicYearList = myList
          .map<AcademicYearModel>((e) => AcademicYearModel.fromJson(e))
          .toList();

      return academicYearList;
    }

    return [];
  }
}
