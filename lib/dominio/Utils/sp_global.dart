import 'package:shared_preferences/shared_preferences.dart';

class SPGlobal{
  static final SPGlobal _instance = SPGlobal._();
  SPGlobal._();

  factory SPGlobal(){
    return _instance;
  }

  late SharedPreferences _prefs;

  Future initShared()async{
    _prefs = await SharedPreferences.getInstance();
  }

  set idPerson(int value){
    _prefs.setInt("idPerson", value);
  }
  int get idPerson => _prefs.getInt('idPerson')??0;

  set documentNumber(String value){
    _prefs.setString("documentNumber", value);
  }
  String get documentNumber => _prefs.getString('documentNumber')??"";

  set jwt(String value){
    _prefs.setString("jwt", value);
  }
  String get jwt => _prefs.getString('jwt')??"";

  // set idToken(String value){
  //   _prefs.setString("idToken", value);
  // }
  // String get idToken => _prefs.getString('idToken')??"";

  set fullName(String value){
    _prefs.setString("fullName", value);
  }
  String get fullName => _prefs.getString('fullName')??"";

  set email(String value){
    _prefs.setString("email", value);
  }
  String get email => _prefs.getString('email')??"";

  set role(String value){
    _prefs.setString("role", value);
  }
  String get role => _prefs.getString('role')??"";

  set image(String value){
    _prefs.setString("image", value);
  }
  String get image => _prefs.getString('image')??"";

  set sectionName(String value){
    _prefs.setString("sectionName", value);
  }
  String get sectionName => _prefs.getString('sectionName')??"";

  set gradeName(String value){
    _prefs.setString("gradeName", value);
  }
  String get gradeName => _prefs.getString('gradeName')??"";

  set isLogin(bool value){
    _prefs.setBool("isLogin", value);
  }
  bool get isLogin => _prefs.getBool('isLogin')??false;

}