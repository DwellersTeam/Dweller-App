import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/create_profile/widget/phase_4/about_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';







class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key, required this.onPressed, required this.backgroundColor, required this.text, required this.textColor, this.width, this.borderRadius, this.height});
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 60.h,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed, // Label text
        style: ElevatedButton.styleFrom(
          elevation: 0,
          enableFeedback: true,
          alignment: Alignment.center,
          backgroundColor: backgroundColor,
          //padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(30.r), // Button border radius
          ),
        ),
        /*icon: Icon(
          size: 20.r,
          CupertinoIcons.chevron_right,
          color: AppColor.whiteColor,
        ),*/ // Icon to be displayed
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700 //w600
          )
        ),
      ),
    );
  }
}




//Edit hobbies and Lifestyle Button
class EditHobbiesButton extends StatelessWidget {
  const EditHobbiesButton({super.key, required this.onPressed, required this.backgroundColor, required this.text, required this.textColor, this.width, this.height});
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Label text
      child: Container(
        //height: height ?? 50.h,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30.r)
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h), // Padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500 //w600
              )
            ),
            SizedBox(width: 10.w,),
            Icon(
              color: textColor,
              size: 20.r,
              Icons.edit
            )
          ],
        ),
      )
    );
  }
}





//Delete Picture Button
class DeletePictureButton extends StatelessWidget {
  const DeletePictureButton({super.key, required this.onPressed, required this.text, this.width,});
  final VoidCallback onPressed;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Label text
      child: Container(
        //height: height ?? 50.h,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.redColorLight,
          borderRadius: BorderRadius.circular(30.r)
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h), // Padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              color: AppColor.darkPurpleColor,
              size: 20.r,
              //Icons.delete,
              CupertinoIcons.check_mark_circled
            ),
            SizedBox(width: 5.w,),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: AppColor.darkPurpleColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500 //w600
              )
            ),
          ],
        ),
      )
    );
  }
}



//Delete Picture Button
class DeletePictureButton2 extends StatelessWidget {
  const DeletePictureButton2({super.key, required this.onPressed, required this.text, this.width,});
  final VoidCallback onPressed;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Label text
      child: Container(
        //height: height ?? 50.h,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.redColorLight,
          borderRadius: BorderRadius.circular(30.r)
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h), // Padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              color: AppColor.darkPurpleColor,
              size: 20.r,
              Icons.delete,
              //CupertinoIcons.check_mark_circled
            ),
            SizedBox(width: 5.w,),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: AppColor.darkPurpleColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500 //w600
              )
            ),
          ],
        ),
      )
    );
  }
}





//Add Picture Button
class AddPictureButton extends StatelessWidget {
  const AddPictureButton({super.key, required this.onPressed, required this.text, this.width,});
  final VoidCallback onPressed;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Label text
      child: Container(
        //height: height ?? 50.h,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.blueColorLightest,
          borderRadius: BorderRadius.circular(30.r)
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h), // Padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              color: AppColor.darkPurpleColor,
              size: 20.r,
              Icons.add
            ),
            SizedBox(width: 5.w,),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: AppColor.darkPurpleColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500 //w600
              )
            ),
          ],
        ),
      )
    );
  }
}





class NoteBox extends StatelessWidget {
  const NoteBox({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: height ?? 50.h,
      width: double.infinity,
      alignment: Alignment.center,
       decoration: BoxDecoration(
        color: AppColor.blueColorLightest,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow:   [
          BoxShadow(
            color: AppColor.semiDarkGreyColor.withOpacity(0.1), //.blackColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ], 
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h), // Padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            color: AppColor.darkPurpleColor,
            size: 20.r,
            CupertinoIcons.info_circle
          ),
          SizedBox(width: 10.w,),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: AppColor.darkPurpleColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500 //w600
              ),
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}