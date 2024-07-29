import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';







class SettingsTextfield extends StatefulWidget {
  const SettingsTextfield({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.initialValue, this.onFocusChanged, this.onFieldSubmitted, this.validator,});
  final String initialValue;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;
  final String? Function(String?)? validator;
  //final Icon suffixIcon;

  @override
  State<SettingsTextfield> createState() => _SettingsTextfieldState();
}

class _SettingsTextfieldState extends State<SettingsTextfield> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        keyboardType: widget.keyboardType,
        maxLines: 5,
        minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.poppins(
          color: AppColor.blackColor, 
          fontSize: 14.sp, 
          fontWeight: FontWeight.w400
        ),             
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        initialValue: widget.initialValue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w), // Adjust padding as needed        
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor,),
            borderRadius: BorderRadius.circular(15.r),
            // Remove the border
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor,), // Set the color you prefer
            borderRadius: BorderRadius.circular(15.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor2,), // Set the color you prefer
            borderRadius: BorderRadius.circular(15.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
            borderRadius: BorderRadius.circular(15.r),
          ),
          errorStyle: GoogleFonts.inter(color: AppColor.redColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
          filled: false,
          fillColor: AppColor.greyColor,     
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            color: AppColor.semiDarkGreyColor, 
            fontSize: 14.sp, //18.sp
            fontWeight: FontWeight.w400 //w500
          ),             
        ),
        validator: widget.validator,

      ),
    );
  }
}


class SettingsTextfield2 extends StatefulWidget {
  const SettingsTextfield2({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, this.onFocusChanged, this.onFieldSubmitted, required this.textController, this.validator,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;
  final String? Function(String?)? validator;
  //final Icon suffixIcon;

  @override
  State<SettingsTextfield2> createState() => _SettingsTextfield2State();
}

class _SettingsTextfield2State extends State<SettingsTextfield2> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        keyboardType: widget.keyboardType,
        maxLines: 5,
        minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.poppins(
          color: AppColor.blackColor, 
          fontSize: 14.sp, 
          fontWeight: FontWeight.w400
        ),             
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        controller: widget.textController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w), // Adjust padding as needed        
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor,),
            borderRadius: BorderRadius.circular(15.r),
            // Remove the border
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor,), // Set the color you prefer
            borderRadius: BorderRadius.circular(15.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor2,), // Set the color you prefer
            borderRadius: BorderRadius.circular(15.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
            borderRadius: BorderRadius.circular(15.r),
          ),
          errorStyle: GoogleFonts.inter(color: AppColor.redColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
          filled: false,
          fillColor: AppColor.greyColor,     
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            color: AppColor.semiDarkGreyColor, 
            fontSize: 14.sp, //18.sp
            fontWeight: FontWeight.w400 //w500
          ),             
        ),
        validator: widget.validator,
      ),
    );
  }
}



class SettingsPasswordTextField extends StatefulWidget {
  SettingsPasswordTextField({super.key, required this.isObscured, required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, this.onFocusChanged, required this.initialValue, this.onFieldSubmitted, this.validator,});
  bool isObscured;
  final String initialValue;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;
   final String? Function(String?)? validator;

  @override
  State<SettingsPasswordTextField> createState() => _SettingsPasswordTextFieldState();
}

class _SettingsPasswordTextFieldState extends State<SettingsPasswordTextField> {
  
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        //maxLines: 2,
        minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.poppins(
          color: AppColor.blackColor, 
          fontSize: 14.sp, 
          fontWeight: FontWeight.w400
        ),             
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        decoration: InputDecoration(    
          
          contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w), // Adjust padding as needed        
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor,),
            borderRadius: BorderRadius.circular(15.r),
            // Remove the border
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor,), // Set the color you prefer
            borderRadius: BorderRadius.circular(15.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor2,), // Set the color you prefer
            borderRadius: BorderRadius.circular(15.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
            borderRadius: BorderRadius.circular(15.r),
          ),
          errorStyle: GoogleFonts.inter(color: AppColor.redColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
          filled: false,
          fillColor: AppColor.greyColor,     
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            color: AppColor.semiDarkGreyColor, 
            fontSize: 14.sp, //18.sp
            fontWeight: FontWeight.w400 //w500
          ), 
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                widget.isObscured = !widget.isObscured;
              });
              debugPrint("${widget.isObscured}");
            },
            child: widget.isObscured 
            ?Icon(
              //CupertinoIcons.eye_slash,
              Icons.visibility_off,
              color: AppColor.semiDarkGreyColor, 
              size: 24.r,
            ) 
            :Icon(
              //CupertinoIcons.eye,
              Icons.visibility_rounded, 
              color: AppColor.semiDarkGreyColor, 
              size: 24.r,
            ) 
          ),  
        ),
        obscureText: widget.isObscured,
        obscuringCharacter: '*',
        validator: widget.validator,
      ),
    );
  }
}





class SettingsPhoneNumberTextField extends StatefulWidget {
  
  const SettingsPhoneNumberTextField({super.key,required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, this.onFocusChanged, required this.icon, this.onFieldSubmitted, required this.initialValue, this.validator,});
  final Widget icon;
  final TextInputType keyboardType;
  final String hintText;
  final String initialValue;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;
   final String? Function(String?)? validator;

  @override
  State<SettingsPhoneNumberTextField> createState() => _SettingsPhoneNumberTextFieldState();
}

class _SettingsPhoneNumberTextFieldState extends State<SettingsPhoneNumberTextField> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(

        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        //maxLines: 2,
        minLines: 1,
        autocorrect: true,
        inputFormatters: const [],
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.poppins(
          color: AppColor.blackColor, 
          fontSize: 14.sp, 
          fontWeight: FontWeight.w400
        ),             
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),

        decoration: InputDecoration(     
          prefixIcon: widget.icon,
          contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w), // Adjust padding as needed        
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor,),
            borderRadius: BorderRadius.circular(15.r),
            // Remove the border
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor,), // Set the color you prefer
            borderRadius: BorderRadius.circular(15.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyColor2,), // Set the color you prefer
            borderRadius: BorderRadius.circular(15.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
            borderRadius: BorderRadius.circular(15.r),
          ),
          errorStyle: GoogleFonts.inter(color: AppColor.redColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
          filled: false,
          fillColor: AppColor.greyColor,     
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            color: AppColor.semiDarkGreyColor, 
            fontSize: 14.sp, //18.sp
            fontWeight: FontWeight.w400 //w500
          ), 

        ),
        validator: widget.validator,
      ),
    );
  }
}