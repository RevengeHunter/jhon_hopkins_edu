import 'package:http/http.dart' as http;

class HTTPGlobal{
  static final HTTPGlobal _instance = HTTPGlobal._();

  HTTPGlobal._();

  factory HTTPGlobal() => _instance;
}