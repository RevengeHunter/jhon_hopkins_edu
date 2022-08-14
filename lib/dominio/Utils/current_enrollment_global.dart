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

  createCurrentEnrollment() {

    _enrollmentService.getCurrentEnrollmentByStudent().then((value) {

      if(value != null){
        _enrollmentCurrentModel = EnrollmentCurrentModel(
          id: value.id,
          personId: value.personId,
          sectionId: value.sectionId,
          sectionName: value.sectionName,
          gradeName: value.gradeName,
          levelName: value.levelName,
          statusEnrollment: value.statusEnrollment,
        );

        _prefs.gradeName = value.gradeName;
        _prefs.sectionName = value.sectionName;
        print(_prefs.gradeName);
        print(_prefs.sectionName);
      }
    });
  }

  EnrollmentCurrentModel get getEnrollmentCurrentModel => _enrollmentCurrentModel;

}