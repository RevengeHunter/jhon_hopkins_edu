import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jhon_hopkins_edu/dominio/Models/user_model.dart';

import '../../Utils/constant.dart';

class AuthenticationLoginService {

  Future<UserModel?> getExternalAuthenticate(String idToken) async {
    Uri url = Uri.parse('$path/ExternalAuthenticate');
    http.Response response = await http.post(url,
      headers: <String, String>{
        'Accept': 'text/plain',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          'idToken': idToken,
        },
      ),
    );

    if(response.statusCode == 200){
      Map<String, dynamic> myMap = jsonDecode(response.body);
      if(!myMap["succeeded"]) return null;
      UserModel userModel = UserModel.fromJson(myMap["data"]);
      return userModel;
    }
    return null;
  }
}
