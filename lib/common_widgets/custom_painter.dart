import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;

  DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    double startX = 0;
    final space = dashSpace + dashWidth;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DashedDivider extends StatelessWidget {
  final Color color;
  final double height;
  final double dashWidth;
  final double dashSpace;

  const DashedDivider({
    super.key,
    this.color = Colors.black,
    this.height = 1.0,
    this.dashWidth = 4.0,
    this.dashSpace = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: DashedLinePainter(
          color: color,
          dashWidth: dashWidth,
          dashSpace: dashSpace,
          strokeWidth: height, 
        ),
      ),
    );
  }
}
