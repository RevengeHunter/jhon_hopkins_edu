import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Modules/Student/Introduction/introduction_page.dart';
import '../../../../dominio/Models/user_model.dart';
import '../../../../dominio/Services/Authentication/authentication_login_service.dart';
import '../../../../dominio/Utils/academic_year_list_global.dart';
import '../../../../dominio/Utils/current_enrollment_global.dart';
import '../../../../dominio/Utils/sp_global.dart';
import '../../Shared/Constants/colors.dart';
import '../../Shared/GeneralWidgets/my_appbar_widget.dart';
import 'Attendance/student_attendance_page.dart';
import 'Payment/student_payment_page.dart';
import 'Score/student_score_page.dart';

class StudentMainPage extends StatefulWidget {
  String studentFoto;
  String studentName;

  StudentMainPage({
    required this.studentFoto,
    required this.studentName,
  });

  @override
  State<StudentMainPage> createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  final AuthenticationLoginService authenticationLoginService =
      AuthenticationLoginService();
  final SPGlobal _prefs = SPGlobal();
  final CurrentEnrollmentGlobal _currentEnrollmentGlobal =
      CurrentEnrollmentGlobal();
  final AcademicYearListGlobal _academicYearListGlobal =
      AcademicYearListGlobal();

  final List<Widget> _pages = [
    IntroductionPage(),
    StudentRecordPage(),
    StudentAttendancePage(),
    StudentPaymentPage(),
  ];

  int _currentPage = 0;

  reGoogleSignIn() async {
    UserModel? userModel =
        await authenticationLoginService.getExternalAuthenticate(_prefs.email);

    if (userModel == null) return;
    RegExp nifRegex = RegExp(r'^[0-9]{8}$');
    if (!userModel.roles.contains('Student') ||
        !nifRegex.hasMatch(userModel.userName)) return;

    _prefs.jwt = userModel.jwtToken;

    await _currentEnrollmentGlobal.createCurrentEnrollment();
    await _academicYearListGlobal.createAcademicYearList();
  }

  getGlobals() async {
    await _academicYearListGlobal.createAcademicYearList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_googleSignIn.currentUser == null) {
      reGoogleSignIn();
    } else {
      getGlobals();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: MyAppBarWidget(studentFoto: widget.studentFoto,),
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontSize: 13.0,
        ),
        selectedFontSize: 14.0,
        unselectedFontSize: 10.0,
        selectedItemColor: kBrandMenuPrimaryColor,
        unselectedItemColor: kBrandMenuSecondaryColor,
        currentIndex: _currentPage,
        onTap: (int value) {
          _currentPage = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pending,
              color:
                  _currentPage == 0 ? kBrandMenuPrimaryColor : kBrandMenuSecondaryColor,
            ),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt_rounded,
              color:
                  _currentPage == 1 ? kBrandMenuPrimaryColor : kBrandMenuSecondaryColor,
            ),
            label: "Notas",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.verified_user_rounded,
              color:
                  _currentPage == 2 ? kBrandMenuPrimaryColor : kBrandMenuSecondaryColor,
            ),
            label: "Asistencia",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_wallet,
              color:
                  _currentPage == 3 ? kBrandMenuPrimaryColor : kBrandMenuSecondaryColor,
            ),
            label: "Deudas",
          ),
        ],
      ),
    );
  }
}
