import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jhon_hopkins_edu/dominio/Models/user_model.dart';
import 'package:jhon_hopkins_edu/dominio/Services/Authentication/authentication_login_service.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/current_enrollment_global.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Modules/Student/student_main_page.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/colors.dart';
import 'package:jhon_hopkins_edu/Presentation/UI/Shared/Constants/space_between.dart';
import '../../../../dominio/Models/person_model.dart';
import '../../../../dominio/Services/Person/person_service.dart';
import '../../../../dominio/Utils/academic_year_list_global.dart';
import '../../Shared/GeneralWidgets/loading_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  //
  final AuthenticationLoginService authenticationLoginService =
      AuthenticationLoginService();

  final SPGlobal _prefs = SPGlobal();
  final AcademicYearListGlobal _academicYearListGlobal =
      AcademicYearListGlobal();
  final CurrentEnrollmentGlobal _currentEnrollmentGlobal =
      CurrentEnrollmentGlobal();
  final PersonService _personService = PersonService();

  bool _isLoading = false;

  final TextEditingController _textEditingController = TextEditingController();

  void _loginWithGoogle() async {
    // GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();

    _isLoading = true;
    setState(() {});

    // if (_googleSignInAccount == null) {
    //   _isLoading = false;
    //   setState(() {});
    //   return;
    // }

    // UserModel? userModel = await authenticationLoginService
    //     .getExternalAuthenticate(_googleSignInAccount.email);

    /*Comentar si se pasa a prod*/
    UserModel? userModel = await authenticationLoginService
       .getExternalAuthenticate(_textEditingController.text);

    if (userModel == null) {
      _isLoading = false;
      setState(() {});
      return;
    }

    _prefs.idPerson = userModel.personId!;
    _prefs.documentNumber = userModel.documentNumber;
    _prefs.role = userModel.roles.first;
    _prefs.isLogin = true;
    _prefs.jwt = userModel.jwtToken;
    _prefs.email = _textEditingController.text;
    _prefs.image = "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg";
    // _prefs.email = _googleSignInAccount.email;//_textEditingController.text;
    // _prefs.image = _googleSignInAccount.photoUrl!;//"https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg";

    PersonModel? personModel = await _personService.getPerson();
    if (personModel == null){
      _isLoading = false;
      setState(() {});
      return;
    }
    _prefs.fullName = '${personModel.firstName} ${personModel.paternalSurname} ${personModel.maternalSurname}';

    _academicYearListGlobal.createAcademicYearList();
    await _currentEnrollmentGlobal.createCurrentEnrollment();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => StudentMainPage(
          studentFoto: _prefs.image,
          studentName: _prefs.fullName,
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Align(
                alignment: Alignment.center,
                child: !_isLoading
                    ? Container(
                        height: height * 0.70,
                        width: width * 0.8,
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/blue-logo.png',
                            ),
                            const Text(
                              "Inicia sesión",
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Text(
                              "Para ingresar al sistema",
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            divider20,
                            TextField(
                              controller: _textEditingController,
                              decoration: const InputDecoration(
                                  hintText: "Correo electronico"),
                              maxLines: 1,
                            ),
                            divider20,
                            ElevatedButton(
                              onPressed: () {
                                _loginWithGoogle();
                                // _googleSignIn.signOut();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/google.png',
                                    height: 25,
                                    width: 25,
                                  ),
                                  dividerWidth10,
                                  const Text(
                                    "Ingresa con Google",
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: kBrandPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const LoadingWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
