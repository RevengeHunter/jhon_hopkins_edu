import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jhon_hopkins_edu/dominio/Models/attendance_model.dart';
import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/colors.dart';
import '../../../../Shared/Constants/font.dart';
import '../../../../Shared/Constants/space_between.dart';

class AttendanceAbsentDetailPage extends StatefulWidget {
  AttendanceModel attendanceModel;

  AttendanceAbsentDetailPage({
    required this.attendanceModel,
  });

  @override
  State<AttendanceAbsentDetailPage> createState() =>
      _AttendanceAbsentDetailPageState();
}

class _AttendanceAbsentDetailPageState
    extends State<AttendanceAbsentDetailPage> {
  final SPGlobal _spGlobal = SPGlobal();
  List<Detail> atendance = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetail();
  }

  getDetail() {
    List<Detail> atendanceAux = widget.attendanceModel.details ?? [];
    atendance =
        atendanceAux.where((element) => element.assistanceType == 2).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 48.0,
          child: Text(
            _spGlobal.fullName,
            style: TextStyle(
              fontSize: 16.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              _spGlobal.image,
            ),
          ),
          dividerWidth20,
        ],
        backgroundColor: kBrandPrimaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Estos son los días que no asististe a clases. Recuerda lo importante que es estar presente para aprender y divertirte.",
                  style: paragraphTextStyle,
                ),
                divider12,
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  //clipBehavior: Clip.none,
                  itemCount: atendance.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: kBrandPrimaryColor.withOpacity(0.12),
                            blurRadius: 8.0,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/calendar.png',
                          scale: 12,
                        ),
                        title: Text(
                          DateFormat('EEEE', 'es')
                              .format(atendance[index].assistanceDate!)
                              .toString(),
                        ),
                        subtitle: Text(
                          atendance[index]
                              .assistanceDate!
                              .toLocal()
                              .toString()
                              .substring(0, 10),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
