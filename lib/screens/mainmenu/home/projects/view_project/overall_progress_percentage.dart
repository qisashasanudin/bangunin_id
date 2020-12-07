import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

CircularPercentIndicator overallProgressPercentage(double percentage) {
  return CircularPercentIndicator(
    circularStrokeCap: CircularStrokeCap.round,
    progressColor: Colors.greenAccent,
    animation: true,
    radius: 100,
    lineWidth: 10,
    percent: percentage,
    center: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Overall',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${percentage * 100}%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
