import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: kBrandPrimaryColor,
        ),
      ),
    );
  }
}
