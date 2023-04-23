import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/colors.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/font.dart';

import '../Constants/space_between.dart';

class LoadingWidget extends StatelessWidget {
  String title;
  String? subTitle;

  LoadingWidget({
    required this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: kBrandPrimaryColor,
              ),
            ),
            divider20,
            Text(
              title,
              style: subTitleTextStyle,
              textAlign: TextAlign.center,
            ),
            divider6,
            Text(
              subTitle ?? "",
              style: titleTextStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
