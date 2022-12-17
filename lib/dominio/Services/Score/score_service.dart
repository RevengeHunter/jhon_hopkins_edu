import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jhon_hopkins_edu/dominio/Models/score_model.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';

import '../../Utils/constant.dart';

class ScoreService {
  final SPGlobal _prefs = SPGlobal();

  Future<List<ScoreModel>> getConsolidationScore(int idAcademicYear) async {
    Uri url = Uri.parse('$path/ConsolidateScore/$idAcademicYear');
    http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'text/plain',
        'Authorization': 'bearer ${_prefs.jwt}',
      },
    );
    print(idAcademicYear);
    print(_prefs.jwt);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = jsonDecode(response.body);
      List myList = myMap["data"];
      List<ScoreModel> consolidationScoreList =
          myList.map((e) => ScoreModel.fromJson(e)).toList();
      return consolidationScoreList;
    }

    return [];
  }
}
