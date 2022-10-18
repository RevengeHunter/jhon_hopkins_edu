import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Models/score_model.dart';
import 'package:jhon_hopkins_edu/dominio/Services/Score/score_service.dart';
import '../../../../../dominio/Models/academic_year_model.dart';
import '../../../../../dominio/Utils/academic_year_list_global.dart';
import '../../../Shared/Constants/colors.dart';
import '../../../Shared/Constants/space_between.dart';
import '../../../Shared/GeneralWidgets/loading_widget.dart';

class StudentRecordPage extends StatefulWidget {
  @override
  State<StudentRecordPage> createState() => _StudentRecordPageState();
}

class _StudentRecordPageState extends State<StudentRecordPage> {
  final ScoreService _scoreService = ScoreService();
  List<ScoreModel> _scoreModelList = [];

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

  academicYearSelected(AcademicYearModel e) {
    if (statusValue != e.academicYearId) {
      _isLoading = true;
      setState(() {});
      statusValue = e.academicYearId;
      _scoreService.getConsolidationScore(e.academicYearId).then((value) {
        if (value != null) {
          _scoreModelList = value;
          _isLoading = false;
          setState(() {});
          return;
        }
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
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    divider12,
                    const Text(
                      "Mis notas",
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
                    divider20,
                    !_isLoading
                        ? Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text("Hola"),
                                    ),
                                  ],
                                ),
                                divider12,
                              ],
                            ),
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
