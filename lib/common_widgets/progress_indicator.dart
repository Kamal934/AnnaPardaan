import 'package:flutter/material.dart';

class ProgressLineIndicator extends StatelessWidget {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final double height;

  const ProgressLineIndicator({
    super.key,
    required this.progress,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.red,
    this.height = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        ),
      ),
    );
  }
}
