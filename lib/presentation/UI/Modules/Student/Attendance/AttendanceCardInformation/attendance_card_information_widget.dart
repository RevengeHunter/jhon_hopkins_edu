import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Models/attendance_model.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Modules/Student/Attendance/AttendanceDetail/attendance_absent_detail_page.dart';

import '../../../../Shared/Constants/colors.dart';
import '../../../../Shared/Constants/space_between.dart';
import '../../../../Shared/GeneralWidgets/chip_information_widget.dart';

class AttendanceCardInformationWidget extends StatelessWidget {
  AttendanceModel attendanceModel;

  AttendanceCardInformationWidget({
    required this.attendanceModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                attendanceModel.courseName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: kBrandPrimaryColor,
                ),
              ),
              Text(
                "${((attendanceModel.quantityAttended*100)/attendanceModel.total).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: kBrandPrimaryColor,

                ),
              ),
            ],
          ),
          Text(
            "Asistencias llamadas: ${attendanceModel.total}",
            style: TextStyle(
              color: kBrandPrimaryColor.withOpacity(0.65),
              fontSize: 16.0,
            ),
          ),
          divider3,
          Divider(
            thickness: 0.8,
            color: kBrandPrimaryColor.withOpacity(0.3),
          ),
          divider6,
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10.0,
            children: [
              ChipInformationWidget(
                text: "Presente: ${attendanceModel.quantityAttended}",
              ),
              ChipInformationWidget(
                text: "Faltas: ${attendanceModel.quantityAbsent}",
              ),
              ChipInformationWidget(
                text: "Permisos: ${attendanceModel.quantityLicense}",
              ),
              ChipInformationWidget(
                text: "Justific??: ${attendanceModel.quantityJustify}",
              ),
            ],
          ),
          Divider(
            thickness: 0.8,
            color: kBrandPrimaryColor.withOpacity(0.3),
          ),
          divider6,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendanceAbsentDetailPage(attendanceModel: attendanceModel,)));
                },
                style: ElevatedButton.styleFrom(primary: kBrandPrimaryColor,),
                child: const Text(
                  "Inasistencias",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
