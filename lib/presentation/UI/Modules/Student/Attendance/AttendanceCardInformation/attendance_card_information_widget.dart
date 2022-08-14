import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Models/attendance_model.dart';

import '../../../../Shared/Constants/colors.dart';
import '../../../../Shared/Constants/space_between.dart';

class AttendanceCardInformationWidget extends StatelessWidget {

  AttendanceModel attendanceModel;
  AttendanceCardInformationWidget({required this.attendanceModel,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.only(right: 15.0,bottom: 15.0,left: 15.0),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            attendanceModel.courseName,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: kBrandPrimaryColor,
            ),
          ),
          Text(
            "Resumen Asistencia: ${attendanceModel.total}",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: kBrandPrimaryColor.withOpacity(0.8),
            ),
          ),
          divider12,
          Divider(
            thickness: 0.8,
            color: Colors.blueAccent.withOpacity(0.65),
          ),
          Text(
            "Asistencias llamadas: ${attendanceModel.total}",
            style: TextStyle(
              color: kBrandPrimaryColor.withOpacity(0.65),
              fontSize: 16.0,
            ),
          ),
          divider6,
          Text(
            "Presente: ${attendanceModel.quantityAttended}",
            style: TextStyle(
              color: kBrandPrimaryColor.withOpacity(0.65),
              fontSize: 16.0,
            ),
          ),
          divider6,
          Text(
            "Faltas: ${attendanceModel.quantityAbsent}",
            style: TextStyle(
              color: kBrandPrimaryColor.withOpacity(0.65),
              fontSize: 16.0,
            ),
          ),
          divider6,
          Text(
            "Permisos: ${attendanceModel.quantityLicense}",
            style: TextStyle(
              color: kBrandPrimaryColor.withOpacity(0.65),
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
