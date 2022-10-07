import 'package:flutter/material.dart';

import '../../../../../dominio/Models/academic_year_model.dart';
import '../../../../../dominio/Utils/academic_year_list_global.dart';
import '../../../Shared/Constants/colors.dart';
import '../../../Shared/Constants/space_between.dart';

class StudentRecordPage extends StatefulWidget {
  @override
  State<StudentRecordPage> createState() => _StudentRecordPageState();
}

class _StudentRecordPageState extends State<StudentRecordPage> {
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
    _isLoading = true;
    setState(() {});
    statusValue = e.academicYearId;
    // _attendanceService
    //     .getAttendance(statusValue, _prefs.documentNumber)
    //     .then((value) {
    //   if (value != null) {
    //     _attendanceList = value;
    //     _isLoading = false;
    //     setState(() {});
    //     return;
    //   }
    //   _isLoading = false;
    //   setState(() {});
    //   return;
    // });
  }

  @override
  Widget build(BuildContext context) {
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
                    divider12,
                    divider12,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      clipBehavior: Clip.none,
                      itemCount: 2,
                      itemBuilder: (BuildContext contex, int index) {
                        return ListTile(
                          title: Text(
                            "Comunicación",
                          ),
                        );
                      },
                    ),
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
