import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';






class AuthTextField extends StatefulWidget {
  const AuthTextField({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, required this.icon, this.validator,});
  final IconData icon;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  final String? Function(String?)? validator;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {

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
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.darkGreyColor,
        //style: GoogleFonts.inter(color: AppColor.blackColor),
        style: GoogleFonts.poppins(color: AppColor.darkGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),             
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(     
          prefixIcon: Icon(
            widget.icon,
            size: 24.r,
            color: AppColor.darkGreyColor,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),   
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColor.semiDarkGreyColor), // Set the color you prefer
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColor.semiDarkGreyColor), // Set the color you prefer
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColor.blueColor), // Set the color you prefer
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColor.redColor), // Set the color you prefer
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




class AuthPhoneNumberTextField extends StatefulWidget {
  const AuthPhoneNumberTextField({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, required this.icon, this.validator,});
  final Widget icon;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  final String? Function(String?)? validator;

  @override
  State<AuthPhoneNumberTextField> createState() => _AuthPhoneNumberTextFieldState();
}

class _AuthPhoneNumberTextFieldState extends State<AuthPhoneNumberTextField> {

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
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.darkGreyColor,
        //style: GoogleFonts.inter(color: AppColor.blackColor),
        style: GoogleFonts.nunitoSans(color: AppColor.darkGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),             
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        decoration: InputDecoration(     
          prefixIcon: widget.icon,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),   
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColor.semiDarkGreyColor), // Set the color you prefer
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColor.semiDarkGreyColor), // Set the color you prefer
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColor.redColor), // Set the color you prefer
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColor.blueColor), // Set the color you prefer
          ),
          fillColor: AppColor.whiteColor, 
          filled: true,    
          hintText: widget.hintText,
          hintStyle: GoogleFonts.nunito(color: AppColor.semiDarkGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),             
          errorStyle: GoogleFonts.nunito(color: AppColor.redColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),

      ),
    );
  }
}



class AuthPasswordTextField extends StatefulWidget {
  AuthPasswordTextField({super.key, required this.isObscured, required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, required this.icon, this.validator,});
  final Widget icon;
  bool isObscured;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  final String? Function(String?)? validator;

  @override
  State<AuthPasswordTextField> createState() => _AuthPasswordTextFieldState();
}

class _AuthPasswordTextFieldState extends State<AuthPasswordTextField> {
  
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        //maxLines: 2,
        minLines: 1,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.darkGreyColor,
        //style: GoogleFonts.inter(color: AppColor.blackColor),
        style: GoogleFonts.nunitoSans(color: AppColor.darkGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),             
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        decoration: InputDecoration(     
          prefixIcon: widget.icon,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),   
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColor.semiDarkGreyColor), // Set the color you prefer
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColor.semiDarkGreyColor), // Set the color you prefer
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColor.blueColor), // Set the color you prefer
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColor.redColor), // Set the color you prefer
          ),
          fillColor: AppColor.whiteColor, 
          filled: true,    
          hintText: widget.hintText,
          hintStyle: GoogleFonts.nunito(color: AppColor.semiDarkGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400), 
          errorStyle: GoogleFonts.nunito(color: AppColor.redColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                widget.isObscured = !widget.isObscured;
              });
              debugPrint("${widget.isObscured}");
            },
            child: widget.isObscured 
            ?Icon(
              CupertinoIcons.eye_slash,
              color: AppColor.semiDarkGreyColor, 
              size: 24.r,
            ) 
            :Icon(
              CupertinoIcons.eye,
              //Icons.visibility_rounded, 
              color: AppColor.semiDarkGreyColor, 
              size: 24.r,
            ) 
          ),  
        ),
        obscureText: widget.isObscured,
        obscuringCharacter: '*',
      ),
    );
  }
}