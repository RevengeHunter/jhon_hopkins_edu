import 'package:flutter/material.dart';
import 'package:jhon_hopkins_edu/presentation/UI/Shared/Constants/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: kBrandPrimaryColor,
        ),
      ),
    );
  }
}
