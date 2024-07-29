import 'dart:ui';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';





class RedSectionPainter extends CustomPainter {


  @override
  void paint(Canvas canvas, Size size) {
    const double blurSigma = 30.0; //90.0 // Define the blur sigma for the blur effect //increase to spread the redcolor blur effect
    final Paint redPaint = Paint()
      ..color = AppColor.blueColor.withOpacity(0.05) // Define the paint for the red color with reduced opacity
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.srcOver
      //..isAntiAlias = true
      ..imageFilter = ImageFilter.blur(
        sigmaX: blurSigma, 
        sigmaY: blurSigma,
        tileMode: TileMode.clamp
      );
    // Define the rectangle representing the area to be painted (center)
    final double paintWidth = size.width * 0.85; // Define the width of the painted area
    final double paintHeight = size.height * 0.2; // Define the height of the painted area
    final double centerX = size.width / 2; // Calculate the center X coordinate
    final double centerY = size.height / 1.75; // Calculate the center Y coordinate
    /*final Rect paintRect = Rect.fromCenter(
      center: Offset(centerX, centerY), 
      width: paintWidth, 
      height: paintHeight
    );*/

    canvas.drawCircle(Offset(centerX, centerY), 200, redPaint);

    // Draw the paint to fill the defined portion of the canvas
    //canvas.drawRect(paintRect, redPaint);
    //canvas.drawPaint(redPaint);

    //canvas.saveLayer(paintRect, redPaint);
    canvas.save();

    // Restore the canvas state
    canvas.restore();
  }

   
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}




class TopRedSectionPainter extends CustomPainter {


  @override
  void paint(Canvas canvas, Size size) {
    const double blurSigma = 30.0; //90.0 // Define the blur sigma for the blur effect //increase to spread the redcolor blur effect
    final Paint redPaint = Paint()
      ..color = AppColor.blueColor.withOpacity(0.05) // Define the paint for the red color with reduced opacity
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.srcOver
      //..isAntiAlias = true
      ..imageFilter = ImageFilter.blur(
        sigmaX: blurSigma, 
        sigmaY: blurSigma,
        tileMode: TileMode.clamp
      );
    // Define the rectangle representing the area to be painted (center)
    final double paintWidth = size.width * 0.85; // Define the width of the painted area
    final double paintHeight = size.height * 0.2; // Define the height of the painted area
    final double centerX = size.width / 2; // Calculate the center X coordinate
    final double centerY = size.height / 2.4; // Calculate the center Y coordinate
    /*final Rect paintRect = Rect.fromCenter(
      center: Offset(centerX, centerY), 
      width: paintWidth, 
      height: paintHeight
    );*/

    canvas.drawCircle(Offset(centerX, centerY), 200, redPaint);

    // Draw the paint to fill the defined portion of the canvas
    //canvas.drawRect(paintRect, redPaint);
    //canvas.drawPaint(redPaint);

    //canvas.saveLayer(paintRect, redPaint);
    canvas.save();

    // Restore the canvas state
    canvas.restore();
  }

   
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class  TopBlueSectionPainter extends CustomPainter {


  @override
  void paint(Canvas canvas, Size size) {
    const double blurSigma = 30.0; //30.0 // Define the blur sigma for the blur effect //increase to spread the redcolor blur effect
    final Paint bluePaint = Paint()
      ..color = AppColor.blueColorOpacity.withOpacity(0.05) // Define the paint for the red color with reduced opacity
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.srcOver
      //..isAntiAlias = true
      ..imageFilter = ImageFilter.blur(
        sigmaX: blurSigma, 
        sigmaY: blurSigma,
        tileMode: TileMode.clamp
      );
    // Define the rectangle representing the area to be painted (center)
    final double paintWidth = size.width; // Define the width of the painted area (full width)
    final double paintHeight = size.height / 2.1; //3.0 Define the height of the painted area (adjust as needed)
    final double centerX = size.width / 2; // Calculate the center X coordinate
    final double centerY = paintHeight / 2; // Calculate the center Y coordinate
    final Rect paintRect = Rect.fromCenter(
      center: Offset(centerX, centerY), 
      width: paintWidth, 
      height: paintHeight
    );

    //canvas.drawCircle(Offset(centerX, centerY), 200, bluePaint);

    // Draw the paint to fill the defined portion of the canvas
    //canvas.drawPaint(bluePaint);
    canvas.drawRect(paintRect, bluePaint);

    //canvas.saveLayer(paintRect, redPaint);
    canvas.save();

    // Restore the canvas state
    canvas.restore();
  }

  


  


   
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
