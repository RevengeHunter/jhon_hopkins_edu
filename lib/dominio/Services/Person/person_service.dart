import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jhon_hopkins_edu/dominio/Models/person_model.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';
import '../../Utils/constant.dart';

class PersonService {
  final SPGlobal _prefs = SPGlobal();

  Future<PersonModel?> getPerson() async {
    Uri url = Uri.parse('$path/Person/${_prefs.idPerson}');
    http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'text/plain',
        'Authorization': 'bearer ${_prefs.jwt}',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = jsonDecode(response.body);
      if(!myMap["succeeded"]) return null;
      PersonModel personModel = PersonModel.fromJson(myMap["data"]);
      return personModel;
    }

    return null;
  }
}