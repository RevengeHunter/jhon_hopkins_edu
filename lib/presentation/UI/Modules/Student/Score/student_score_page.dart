import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Models/score_model.dart';
import 'package:jhon_hopkins_edu/dominio/Services/Enrollment/enrollment_service.dart';
import 'package:jhon_hopkins_edu/dominio/Services/Score/score_service.dart';
import '../../../../../dominio/Models/academic_year_model.dart';
import '../../../../../dominio/Models/enrollment_with_course_model.dart';
import '../../../../../dominio/Utils/academic_year_list_global.dart';
import '../../../Shared/Constants/colors.dart';
import '../../../Shared/Constants/space_between.dart';
import '../../../Shared/GeneralWidgets/loading_widget.dart';
import '../../../Shared/GeneralWidgets/not_found_widget.dart';
import 'ScoreCardInformation/score_card_information_widget.dart';

class StudentRecordPage extends StatefulWidget {
  @override
  State<StudentRecordPage> createState() => _StudentRecordPageState();
}

class _StudentRecordPageState extends State<StudentRecordPage> {
  final ScoreService _scoreService = ScoreService();
  final EnrollmentService _enrollmentService = EnrollmentService();
  List<ScoreModel> _scoreModelList = [];
  List<EnrollmentWithCourseModel> _enrollmentWithCourseModelList = [];

  Widget responseWidget = Column();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final AcademicYearListGlobal _academicYearListGlobal =
      AcademicYearListGlobal();

  // final SPGlobal _prefs = SPGlobal();

  int statusValue = 0;
  bool _isLoading = false;
  double height = 0.0;
  double width = 0.0;

  academicYearSelected(AcademicYearModel e) {
    if (statusValue != e.academicYearId) {
      _isLoading = true;
      setState(() {});
      statusValue = e.academicYearId;

      _scoreService.getConsolidationScore(e.academicYearId).then((value) {
        if (value.isNotEmpty) {
          _scoreModelList = value;
          _isLoading = false;
          setState(() {});
          return;
        }
        _isLoading = false;
        setState(() {});
        return;
      });

      _enrollmentService
          .getEnrollmentWithCourseByAcademicPeriod(e.academicYearId)
          .then((value) {
        if (value.isNotEmpty) {
          _enrollmentWithCourseModelList = value;

          responseWidget = Column(
            children: _enrollmentWithCourseModelList
                .map(
                  (e) => ScoreCardInformationWidget(
                    courseName: e.courseName,
                    idAcademicYear: statusValue,
                    scoreConsolidationCourseList: _scoreModelList
                        .where((element) => element.courseId == e.courseId)
                        .toList(),
                  ),
                )
                .toList(),
          );

          setState(() {});
          return;
        }

        responseWidget = NotFoundWidget(
          message:
              "Aún no se tiene las notas del bimestre para el año académico seleccionado.",
          alto: height,
          ancho: width,
        );
        setState(() {});
        return;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //BackgroundLogoWidget(),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    divider12,
                    const Text(
                      "Mis notas",
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
