import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Models/academic_year_model.dart';
import 'package:jhon_hopkins_edu/dominio/Services/Attendance/attendance_service.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/GeneralWidgets/loading_widget.dart';

import '../../../../../dominio/Models/attendance_model.dart';
import '../../../../../dominio/Utils/academic_year_list_global.dart';
import '../../../../../dominio/Utils/sp_global.dart';
import '../../../Shared/Constants/colors.dart';
import '../../../Shared/Constants/space_between.dart';
import '../../../Shared/GeneralWidgets/background_logo_widget.dart';
import 'AttendanceCardInformation/attendance_card_information_widget.dart';

class StudentAttendancePage extends StatefulWidget {
  const StudentAttendancePage({Key? key}) : super(key: key);

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  final AttendanceService _attendanceService = AttendanceService();
  final AcademicYearListGlobal _academicYearListGlobal =
      AcademicYearListGlobal();
  final SPGlobal _prefs = SPGlobal();

  int statusValue = 0;
  bool _isLoading = false;

  List<AttendanceModel> _attendanceList = [];

  academicYearSelected(AcademicYearModel e) {
    _isLoading = true;
    setState(() {});
    statusValue = e.academicYearId;
    _attendanceService
        .getAttendance(statusValue, _prefs.documentNumber)
        .then((value) {
      if (value != null) {
        _attendanceList = value;
        _isLoading = false;
        setState(() {});
        return;
      }
      _isLoading = false;
      setState(() {});
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundLogoWidget(),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              //clipBehavior: Clip.none,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    divider12,
                    const Text(
                      "Mi asistencia",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: kBrandPrimaryColor,
                      ),
                    ),
                    divider3,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Periodo académico:",
                        ),
                        dividerWidth20,
                        Wrap(
                          children: _academicYearListGlobal.getAcademicYearList
                              .map(
                                (e) => FilterChip(
                                  selected: statusValue == e.academicYearId,
                                  selectedColor: statusColor["Selected"],
                                  label: Text(e.academicYearName),
                                  labelStyle: TextStyle(
                                    color: statusValue == e.academicYearId
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: statusValue == e.academicYearId
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                  checkmarkColor: Colors.white,
                                  onSelected: (bool isSelected) {
                                    academicYearSelected(e);
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    divider12,
                    !_isLoading
                        ? Column(
                            children: _attendanceList
                                .map(
                                  (e) => AttendanceCardInformationWidget(
                                      attendanceModel: e),
                                )
                                .toList(),
                          )
                        : SizedBox(
                            height: height * 0.7,
                            width: width,
                            child: const LoadingWidget(),
                          ),
                    divider20,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
