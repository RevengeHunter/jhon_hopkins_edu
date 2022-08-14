import 'package:flutter/material.dart';

class StudentRecordPage extends StatelessWidget {
  const StudentRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: Text("Notas del estudiante",),),
      ),
    );
  }
}
