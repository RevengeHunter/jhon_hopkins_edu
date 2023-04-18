import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/dominio/Models/bimester_model.dart';
import 'package:jhon_hopkins_edu/dominio/Models/score_model.dart';
import 'package:jhon_hopkins_edu/dominio/Services/Bimester/bimester_service.dart';

import '../../../../Shared/Constants/colors.dart';
import '../../../../Shared/Constants/space_between.dart';

class ScoreCardInformationWidget extends StatefulWidget {
  int idAcademicYear;
  String courseName;
  List<ScoreModel> scoreConsolidationCourseList;

  ScoreCardInformationWidget({
    required this.idAcademicYear,
    required this.courseName,
    required this.scoreConsolidationCourseList,
  });

  @override
  State<ScoreCardInformationWidget> createState() =>
      _ScoreCardInformationWidgetState();
}

class _ScoreCardInformationWidgetState
    extends State<ScoreCardInformationWidget> {
  final BimesterService _bimesterService = BimesterService();
  List<BimesterModel> _bimesterModelList = [];
  List<ScoreModel> scoreConsolidationCourseListAux = [];
  List<Map<String, dynamic>> bimesterScoreList = [];

  @override
  void initState() {
    super.initState();
    getBimesters();
  }

  void getBimesters() async {
    _bimesterModelList =
        await _bimesterService.getAllBimesters(widget.idAcademicYear);

    for (var element in _bimesterModelList) {
      Map<String, dynamic> bimesterScore = {};
      bimesterScore["bimester"] = element.name;
      if (widget.scoreConsolidationCourseList
              .where((i) => i.bimesterId == element.bimesterId)
              .toList()
              .length ==
          1) {
        bimesterScore["score"] = widget.scoreConsolidationCourseList
            .where((i) => i.bimesterId == element.bimesterId)
            .toList()
            .first
            .consolidationScoreValue;
      } else {
        bimesterScore["score"] = "-";
      }
      bimesterScoreList.add(bimesterScore);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      margin: const EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.courseName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: kBrandPrimaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          divider12,
          Text(
            "Consolidado del curso: ",
            style: TextStyle(
              color: kBrandPrimaryColor.withOpacity(0.65),
              fontSize: 14.0,
            ),
          ),
          divider3,
          const Divider(),
          divider3,
          GridView.builder(
            itemCount: _bimesterModelList.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 18.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 2.4,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 5,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      bimesterScoreList[index]['bimester'],
                      style: TextStyle(
                        color: kBrandPrimaryColor.withOpacity(0.8),
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      bimesterScoreList[index]['score'].toString(),
                      style: const TextStyle(
                        color: kBrandPrimaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
