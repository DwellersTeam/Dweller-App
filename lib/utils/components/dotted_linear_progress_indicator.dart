import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class DottedLinearProgressIndicator extends StatelessWidget {
  final double value;
  final Color color;
  final Color backgroundColor;
  final double height;
  final double dotWidth;
  final double spacing;

  const DottedLinearProgressIndicator({super.key, 
    required this.value,
    this.color = AppColor.whiteColor,
    this.backgroundColor = AppColor.semiDarkGreyColor,
    this.height = 2.5,
    this.dotWidth = 40.0,
    this.spacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedLinearProgressPainter(
        value: value,
        color: color,
        backgroundColor: backgroundColor,
        height: height,
        dotWidth: dotWidth,
        spacing: spacing,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
        ),
        height: height,
      ),
    );
  }
}

class _DottedLinearProgressPainter extends CustomPainter {
  final double value;
  final Color color;
  final Color backgroundColor;
  final double height;
  final double dotWidth;
  final double spacing;

  _DottedLinearProgressPainter({
    required this.value,
    required this.color,
    required this.backgroundColor,
    required this.height,
    required this.dotWidth,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double progressWidth = size.width * value;
    double dotSpacing = dotWidth + spacing;

    // Draw background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, height), backgroundPaint);

    // Draw progress
    for (double x = 0; x < progressWidth; x += dotSpacing) {
      double endX = x + dotWidth;
      if (endX > progressWidth) {
        endX = progressWidth;
      }
      canvas.drawRRect(
          RRect.fromLTRBR(x, 0, endX, height, Radius.circular(dotWidth / 2)),
          progressPaint);
    }
  }

  @override
  bool shouldRepaint(_DottedLinearProgressPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
