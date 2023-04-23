import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Models/academic_year_model.dart';
import 'package:jhon_hopkins_edu/dominio/Services/Attendance/attendance_service.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/GeneralWidgets/loading_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../dominio/Models/attendance_model.dart';
import '../../../../../dominio/Utils/academic_year_list_global.dart';
import '../../../../../dominio/Utils/sp_global.dart';
import '../../../Shared/Constants/colors.dart';
import '../../../Shared/Constants/font.dart';
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

          List<Widget> _attendanceListWithStatus = [];

          _attendanceList.forEach((element) {
            Icon attendanceStatusIcon = getIconStatusAttendance(element);
            _attendanceListWithStatus.add(
              AttendanceCardInformationWidget(
                attendanceModel: element,
                attendaceStatusIcon: attendanceStatusIcon,
              ),
            );
          });

          responseWidget = Column(
            children: _attendanceListWithStatus,
          );

          _isLoading = false;
          setState(() {});
          return;
        }

        responseWidget = NotFoundWidget(
          message:
              "No tiene asistencias registradas en el año académico seleccionado.",
          alto: height,
          ancho: width,
        );

        _isLoading = false;
        setState(() {});
        return;
      });
    }
  }

  Icon getIconStatusAttendance(AttendanceModel attendanceModel) {
    double attendancePercentage = attendanceModel.getAttendancePorcentage();

    late Icon _attendanceStatusIcon;

    if (attendancePercentage >= 60.0) {
      _attendanceStatusIcon = Icon(
        FontAwesomeIcons.solidFaceSmileBeam,
        color: trafficLightColor["Great"],
      );
    } else if (60.0 > attendancePercentage && attendancePercentage > 30.0) {
      _attendanceStatusIcon = Icon(
        FontAwesomeIcons.solidFaceMeh,
        color: trafficLightColor["Caution"],
      );
    } else if (attendancePercentage <= 30.0) {
      _attendanceStatusIcon = Icon(
        FontAwesomeIcons.solidFaceFrown,
        color: trafficLightColor["Fail"],
      );
    } else {
      _attendanceStatusIcon = const Icon(
        FontAwesomeIcons.lock,
        color: kBrandPrimaryColor,
      );
    }

    return _attendanceStatusIcon;
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
                    const SizedBox(
                      width: double.infinity,
                    ),
                    divider12,
                    const Text(
                      "Mi asistencia",
                      style: titleTextStyle,
                    ),
                    divider3,
                    const Text(
                      "Elige un periodo académico para realizar la consulta.",
                      style: subTitleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    divider12,
                    _academicYearListGlobal.getAcademicYearList.isNotEmpty
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Wrap(
                                children: _academicYearListGlobal
                                    .getAcademicYearList
                                    .map(
                                      (e) => FilterChip(
                                        selected:
                                            statusValue == e.academicYearId,
                                        selectedColor: statusColor["Selected"],
                                        padding: const EdgeInsets.all(2),
                                        label: Text(
                                          e.academicYearName,
                                          style: chipTextStyle,
                                        ),
                                        labelStyle: TextStyle(
                                          color: statusValue == e.academicYearId
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight:
                                              statusValue == e.academicYearId
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
                          )
                        : NotFoundWidget(
                            message:
                                "No se encontro ningún año académico en el que este matriculado",
                            alto: height,
                            ancho: width),
                    divider20,
                    !_isLoading
                        ? responseWidget
                        : SizedBox(
                            height: height * 0.45,
                            width: width,
                            child: LoadingWidget(
                              title: "Cargando los cursos y su asistencia...",
                              subTitle: "Por favor espere.",
                            ),
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
