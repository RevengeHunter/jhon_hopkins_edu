import 'package:flutter/material.dart';

// import 'package:jhon_hopkins_edu/dominio/Utils/academic_year_list_global.dart';
// import 'package:jhon_hopkins_edu/dominio/Utils/current_enrollment_global.dart';
import '../../../../dominio/Utils/academic_year_list_global.dart';
import '../../Shared/Constants/colors.dart';
import '../../Shared/GeneralWidgets/my_appbar_widget.dart';
import 'Attendance/student_attendance_page.dart';
import 'Payment/student_payment_page.dart';
import 'Record/student_record_page.dart';

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
  int _currentPage = 0;

  final List<Widget> _pages = [
    StudentRecordPage(),
    StudentAttendancePage(),
    StudentPaymentPage(),
  ];

  final AcademicYearListGlobal _academicYearListGlobal =
      AcademicYearListGlobal();

  getGlobals() async {
    await _academicYearListGlobal.createAcademicYearList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGlobals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: MyAppBarWidget(
          text: widget.studentName,
          image: widget.studentFoto,
        ),
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 13.0,
        ),
        selectedFontSize: 13.0,
        unselectedFontSize: 11.0,
        selectedItemColor: kBrandPrimaryColor,
        unselectedItemColor: kBrandSecondaryColor,
        currentIndex: _currentPage,
        onTap: (int value) {
          _currentPage = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt_rounded,
              color:
                  _currentPage == 0 ? kBrandPrimaryColor : kBrandSecondaryColor,
            ),
            label: "Notas",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.verified_user_rounded,
              color:
                  _currentPage == 1 ? kBrandPrimaryColor : kBrandSecondaryColor,
            ),
            label: "Asistencia",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_balance_wallet,
              color:
                  _currentPage == 2 ? kBrandPrimaryColor : kBrandSecondaryColor,
            ),
            label: "Deudas",
          ),
        ],
      ),
    );
  }
}
