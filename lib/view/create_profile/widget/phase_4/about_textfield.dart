import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';









class AboutTextField extends StatefulWidget {
  const AboutTextField({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, required this.icon,});
  final IconData icon;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;

  @override
  State<AboutTextField> createState() => _AboutTextFieldState();
}

class _AboutTextFieldState extends State<AboutTextField> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        maxLines: 10,
        minLines: 3,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        //style: GoogleFonts.inter(color: AppColor.blackColor),
        style: GoogleFonts.poppins(color: AppColor.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w400),             
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        decoration: InputDecoration(     
          prefixIcon: Icon(
            widget.icon,
            size: 24.r,
            color: AppColor.lightGreyColor,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),   
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColor.lightGreyColor), // Set the color you prefer
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColor.lightGreyColor), // Set the color you prefer
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColor.semiDarkGreyColor), // Set the color you prefer
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColor.redColor), // Set the color you prefer
          ),
          fillColor: AppColor.whiteColor, 
          filled: true,    
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(color: AppColor.semiDarkGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400), 
          errorStyle: GoogleFonts.poppins(color: AppColor.redColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}