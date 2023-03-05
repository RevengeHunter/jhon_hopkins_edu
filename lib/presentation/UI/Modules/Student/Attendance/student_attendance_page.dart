import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Models/academic_year_model.dart';
import 'package:jhon_hopkins_edu/dominio/Services/Attendance/attendance_service.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/GeneralWidgets/loading_widget.dart';

import '../../../../../dominio/Models/attendance_model.dart';
import '../../../../../dominio/Utils/academic_year_list_global.dart';
import '../../../../../dominio/Utils/sp_global.dart';
import '../../../Shared/Constants/colors.dart';
import '../../../Shared/Constants/space_between.dart';
import '../../../Shared/GeneralWidgets/not_found_widget.dart';
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
  double height = 0.0;
  double width = 0.0;
  Widget responseWidget = SizedBox();

  List<AttendanceModel> _attendanceList = [];

  academicYearSelected(AcademicYearModel e) {
    if (statusValue != e.academicYearId) {
      _isLoading = true;
      setState(() {});
      statusValue = e.academicYearId;
      _attendanceService
          .getAttendance(statusValue, _prefs.documentNumber)
          .then((value) {
        if (value != null) {
          _attendanceList = value;

          responseWidget = Column(
            children: _attendanceList
                .map(
                  (e) => AttendanceCardInformationWidget(attendanceModel: e),
                )
                .toList(),
          );

          _isLoading = false;
          setState(() {});
          return;
        }

        responseWidget = NotFoundWidget(
          message:
              "Aún no se tiene las asistencias del curso para el año académico seleccionado.",
          alto: height,
          ancho: width,
        );

        _isLoading = false;
        setState(() {});
        return;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //BackgroundLogoWidget(),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              //clipBehavior: Clip.none,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    divider12,
                    const Text(
                      "Mi asistencia",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w700,
                        color: kBrandPrimaryColor,
                      ),
                    ),
                    divider3,
                    const Text(
                      "Elige un periodo académico para realizar la consulta.",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: kBrandPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    divider3,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          children: _academicYearListGlobal.getAcademicYearList
                              .map(
                                (e) => FilterChip(
                                  selected: statusValue == e.academicYearId,
                                  selectedColor: statusColor["Selected"],
                                  padding: const EdgeInsets.all(2),
                                  label: Text(
                                    e.academicYearName,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
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
                    divider20,
                    !_isLoading
                        ? responseWidget
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
