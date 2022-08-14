import 'package:jhon_hopkins_edu/dominio/Utils/sp_global.dart';

import '../Models/enrollment_current_model.dart';
import '../Services/Enrollment/enrollment_service.dart';

class CurrentEnrollmentGlobal {
  static final CurrentEnrollmentGlobal _instance = CurrentEnrollmentGlobal._();

  CurrentEnrollmentGlobal._();

  factory CurrentEnrollmentGlobal(){
    return _instance;
  }

  final SPGlobal _prefs = SPGlobal();
  final EnrollmentService _enrollmentService = EnrollmentService();
  late EnrollmentCurrentModel _enrollmentCurrentModel;

  Future<EnrollmentCurrentModel> createCurrentEnrollment() async {
    EnrollmentCurrentModel? enrollmentCurrentModel = await _enrollmentService.getCurrentEnrollmentByStudent();
    _enrollmentCurrentModel = EnrollmentCurrentModel(
      id: enrollmentCurrentModel!.id,
      personId: enrollmentCurrentModel.personId,
      sectionId: enrollmentCurrentModel.sectionId,
      sectionName: enrollmentCurrentModel.sectionName,
      gradeName: enrollmentCurrentModel.gradeName,
      levelName: enrollmentCurrentModel.levelName,
      statusEnrollment: enrollmentCurrentModel.statusEnrollment,
    );

    _prefs.gradeName = enrollmentCurrentModel.gradeName;
    _prefs.sectionName = enrollmentCurrentModel.sectionName;

    return _enrollmentCurrentModel;
  }

  EnrollmentCurrentModel get getEnrollmentCurrentModel => _enrollmentCurrentModel;

}