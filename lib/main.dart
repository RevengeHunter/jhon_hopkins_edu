import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Modules/Student/student_main_page.dart';
import 'dominio/Utils/sp_global.dart';
import 'presentation/UI/Modules/Authentication/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SPGlobal _prefs = SPGlobal();
  await _prefs.initShared();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: PreInit(),
    );
  }
}

class PreInit extends StatelessWidget {
  final SPGlobal _prefs = SPGlobal();

  @override
  Widget build(BuildContext context) {
    return _prefs.isLogin
        ? StudentMainPage(
            studentName: _prefs.fullName,
            studentFoto: _prefs.image,
          )
        : LoginPage();
  }
}
