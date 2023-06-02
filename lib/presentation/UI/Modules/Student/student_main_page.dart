// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Modules/Student/Introduction/introduction_page.dart';
import '../../../../dominio/Models/user_model.dart';
import '../../../../dominio/Services/Authentication/authentication_login_service.dart';
import '../../../../dominio/Utils/academic_year_list_global.dart';
import '../../../../dominio/Utils/current_enrollment_global.dart';
import '../../../../dominio/Utils/sp_global.dart';
import '../../Shared/Constants/colors.dart';
import '../../Shared/GeneralWidgets/my_appbar_widget.dart';
import '../../Shared/GeneralWidgets/loading_widget.dart';
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

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  final List<Widget> _pages = [
    IntroductionPage(),
    StudentRecordPage(),
    const StudentAttendancePage(),
    StudentPaymentPage(),
  ];

  int _currentPage = 0;
  bool _isLoading = false;

  reGoogleSignIn() async {
    _isLoading = true;
    setState(() {});

    await initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    if (_connectionStatus == ConnectivityResult.none) {
      _isLoading = false;
      setState(() {});
      return;
    }

    UserModel? userModel =
        await authenticationLoginService.getExternalAuthenticate(_prefs.email);

    if (userModel == null || _connectionStatus == ConnectivityResult.none) {
      _isLoading = false;
      setState(() {});
      return;
    }

    RegExp nifRegex = RegExp(r'^[0-9]{8}$');
    if (!userModel.roles.contains('Student') ||
        !nifRegex.hasMatch(userModel.userName)) return;

    _prefs.jwt = userModel.jwtToken;

    await _currentEnrollmentGlobal.createCurrentEnrollment();
    await _academicYearListGlobal.createAcademicYearList();

    _isLoading = false;
    setState(() {});
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
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: MyAppBarWidget(
          studentFoto: widget.studentFoto,
        ),
      ),
      body: !_isLoading
          ? _pages[_currentPage]
          : LoadingWidget(
              title: "Cargando servicios.",
              subTitle:
                  "Por favor espere. Esto pueder tardar varios minutos...",
            ),
      bottomNavigationBar: !_isLoading
          ? BottomNavigationBar(
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
                    color: _currentPage == 0
                        ? kBrandMenuPrimaryColor
                        : kBrandMenuSecondaryColor,
                  ),
                  label: "Inicio",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list_alt_rounded,
                    color: _currentPage == 1
                        ? kBrandMenuPrimaryColor
                        : kBrandMenuSecondaryColor,
                  ),
                  label: "Notas",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.verified_user_rounded,
                    color: _currentPage == 2
                        ? kBrandMenuPrimaryColor
                        : kBrandMenuSecondaryColor,
                  ),
                  label: "Asistencia",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_balance_wallet,
                    color: _currentPage == 3
                        ? kBrandMenuPrimaryColor
                        : kBrandMenuSecondaryColor,
                  ),
                  label: "Deudas",
                ),
              ],
            )
          : BottomNavigationBar(
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
                    color: _currentPage == 0
                        ? kBrandMenuPrimaryColor
                        : kBrandMenuSecondaryColor,
                  ),
                  label: "Inicio",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.output,
                    color: _currentPage == 1
                        ? kBrandMenuPrimaryColor
                        : kBrandMenuSecondaryColor,
                  ),
                  label: "Cargando servicios...",
                ),
              ],
            ),
    );
  }
}
