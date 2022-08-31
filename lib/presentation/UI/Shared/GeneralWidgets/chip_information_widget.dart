import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class ChipInformationWidget extends StatelessWidget {
  String text;

  ChipInformationWidget({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        text,
        style: TextStyle(
          color: kBrandPrimaryColor.withOpacity(0.65),
          fontSize: 16.0,
        ),
      ),
    );
  }
}
