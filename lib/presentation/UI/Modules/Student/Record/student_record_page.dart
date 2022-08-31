import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/GeneralWidgets/background_logo_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundLogoWidget(),
            Center(
              child: Text(
                "Aqui se veran las notas",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
