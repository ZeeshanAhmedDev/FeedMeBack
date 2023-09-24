import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import '../../config/themes/theme.dart';

Widget progressBar(int currentStep, int totalStep) {
  return LinearProgressBar(
    maxSteps: totalStep,
    progressType: LinearProgressBar.progressTypeDots,
    currentStep: currentStep,
    progressColor: Color(AppColor.lightgreen),
    backgroundColor: Colors.grey.shade400,
    dotsAxis: Axis.horizontal, // OR Axis.vertical
    dotsActiveSize: 10,
    dotsInactiveSize: 10,
    dotsSpacing: EdgeInsets.only(right: 10), // also can use any EdgeInsets.
  );
}
