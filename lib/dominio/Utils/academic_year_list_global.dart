import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';

import '../Models/academic_year_model.dart';
import '../Services/Academic/academic_year_service.dart';

class AcademicYearListGlobal {
  static final AcademicYearListGlobal _instance = AcademicYearListGlobal._();

  AcademicYearListGlobal._();

  factory AcademicYearListGlobal(){
    return _instance;
  }

  final SPGlobal _sharp = SPGlobal();

  final AcademicYearService _academicYearService = AcademicYearService();
  List<AcademicYearModel> _academicYearList = [];

  List<AcademicYearModel> get getAcademicYearList => _academicYearList;

  createAcademicYearList() {
    _academicYearService.getAcademicYearList(_sharp.documentNumber).then((value){
      _academicYearList = value;
    });
  }

  clearAcademicYearList() {
    _academicYearList.clear();
  }
}