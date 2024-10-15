import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';






class ProfileTextField extends StatefulWidget {
  const ProfileTextField({super.key, this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, required this.icon, this.onTap, this.onFieldSubmitted,});
  final IconData icon;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  final void Function()? onTap;

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        maxLines: 2,
        minLines: 1,
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
            color: AppColor.darkGreyColor,
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


//for adding host property infomation screen
class ProfileTextField2 extends StatefulWidget {
  const ProfileTextField2({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, this.onTap, this.onFieldSubmitted,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;
  final void Function()? onTap;

  @override
  State<ProfileTextField2> createState() => _ProfileTextField2State();
}

class _ProfileTextField2State extends State<ProfileTextField2> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        maxLines: 2,
        minLines: 1,
        autocorrect: true,
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

//for editing host property infomation screen
class ProfileTextField3 extends StatefulWidget {
  const ProfileTextField3({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, this.onFocusChanged, required this.initialValue, this.onTap,});
  final String initialValue;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  final void Function()? onTap;

  @override
  State<ProfileTextField3> createState() => _ProfileTextField3State();
}

class _ProfileTextField3State extends State<ProfileTextField3> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        maxLines: 2,
        minLines: 1,
        autocorrect: true,
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



//for phone number
class ProfilePhoneNumberTextField extends StatefulWidget {
  const ProfilePhoneNumberTextField({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, required this.icon,});
  final Widget icon;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;

  @override
  State<ProfilePhoneNumberTextField> createState() => _ProfilePhoneNumberTextFieldState();
}

class _ProfilePhoneNumberTextFieldState extends State<ProfilePhoneNumberTextField> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        maxLines: 2,
        minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        //style: GoogleFonts.inter(color: AppColor.blackColor),
        style: GoogleFonts.nunitoSans(color: AppColor.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w400),             
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        decoration: InputDecoration(     
          prefixIcon: widget.icon,
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
