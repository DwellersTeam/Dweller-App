import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';







class SearchTextfield extends StatefulWidget {
  const SearchTextfield({super.key, this.inputFormatters, required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, required this.suffixIcon, this.validator,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(bool)? onFocusChanged;
  final String? Function(String?)? validator;
  final Icon suffixIcon;

  @override
  State<SearchTextfield> createState() => _SearchTextfieldState();
}

class _SearchTextfieldState extends State<SearchTextfield> {

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
        inputFormatters: widget.inputFormatters,
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
            borderSide: BorderSide(color: AppColor.pureLightGreyColor,),
            borderRadius: BorderRadius.circular(50.r),
            // Remove the border
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.pureLightGreyColor,), // Set the color you prefer
            borderRadius: BorderRadius.circular(50.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.pureLightGreyColor,), // Set the color you prefer
            borderRadius: BorderRadius.circular(50.r),
          ),
          /*errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
            borderRadius: BorderRadius.circular(15.r),
          ),
          errorStyle: GoogleFonts.inter(color: AppColor.redColor, fontSize: 14.sp, fontWeight: FontWeight.w400),*/
          filled: true,
          fillColor: AppColor.pureLightGreyColor,     
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            color: AppColor.blackColor, 
            fontSize: 14.sp, //18.sp
            fontWeight: FontWeight.w400 //w500
          ),             
          suffixIcon: widget.suffixIcon,
        ),
        validator: widget.validator,
      ),
    );
  }
}


class MessageTextInputfield extends StatefulWidget {
  const MessageTextInputfield({super.key,this.inputFormatters, required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, this.suffixIcon, this.onFieldSubmitted, this.prefixIcon,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  State<MessageTextInputfield> createState() => _MessageTextInputfieldState();
}

class _MessageTextInputfieldState extends State<MessageTextInputfield> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        maxLines: 10,
        minLines: 1,
        autocorrect: true,
        inputFormatters: widget.inputFormatters,
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.poppins(
          color: AppColor.blackColor, 
          fontSize: 12.sp, 
          fontWeight: FontWeight.w400
        ),             
        textCapitalization: TextCapitalization.sentences,
        textInputAction: widget.textInputAction,          
        scrollPhysics: const BouncingScrollPhysics(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w), // Adjust padding as needed        
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.pureLightGreyColor,),
            borderRadius: BorderRadius.circular(50.r),
            // Remove the border
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.pureLightGreyColor,), // Set the color you prefer
            borderRadius: BorderRadius.circular(50.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.pureLightGreyColor,), // Set the color you prefer
            borderRadius: BorderRadius.circular(50.r),
          ),
          /*errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor),
            borderRadius: BorderRadius.circular(15.r),
          ),
          errorStyle: GoogleFonts.inter(color: AppColor.redColor, fontSize: 14.sp, fontWeight: FontWeight.w400),*/
          filled: true,
          fillColor: AppColor.pureLightGreyColor,     
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            color: AppColor.semiDarkGreyColor, 
            fontSize: 12.sp, //18.sp
            fontWeight: FontWeight.w400 //w500
          ),
          prefixIcon: widget.prefixIcon,             
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}



class TaskTextInputfield extends StatefulWidget {
  const TaskTextInputfield({super.key,this.inputFormatters, required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, required this.textController, this.onFocusChanged, this.onFieldSubmitted,});
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;


  @override
  State<TaskTextInputfield> createState() => _TaskTextInputfieldState();
}

class _TaskTextInputfieldState extends State<TaskTextInputfield> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: widget.textController,
        keyboardType: widget.keyboardType,
        maxLines: 8,
        minLines: 1,
        autocorrect: true,
        inputFormatters: widget.inputFormatters,
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.poppins(
          color: AppColor.blackColor, 
          fontSize: 12.sp, 
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
            borderSide: BorderSide(color: AppColor.greyColor,), // Set the color you prefer
            borderRadius: BorderRadius.circular(15.r),
          ),
          filled: true,
          fillColor: AppColor.greyColor,     
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            color: AppColor.semiDarkGreyColor, 
            fontSize: 12.sp, //18.sp
            fontWeight: FontWeight.w400 //w500
          ),
          //prefixIcon: widget.prefixIcon,             
          //suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}





class TaskTextInputfieldEdit extends StatefulWidget {
  const TaskTextInputfieldEdit({super.key, this.inputFormatters, required this.onChanged, required this.hintText, required this.keyboardType, required this.textInputAction, this.onFocusChanged, this.onFieldSubmitted, required this.initialValue,});
  final String initialValue;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(bool)? onFocusChanged;


  @override
  State<TaskTextInputfieldEdit> createState() => _TaskTextInputfieldEditState();
}

class _TaskTextInputfieldEditState extends State<TaskTextInputfieldEdit> {

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: widget.onFocusChanged,
      child: TextFormField(
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        maxLines: 8,
        minLines: 1,
        autocorrect: true,
        inputFormatters: widget.inputFormatters,
        enableSuggestions: true,
        enableInteractiveSelection: true,
        cursorColor: AppColor.blackColor,
        style: GoogleFonts.poppins(
          color: AppColor.blackColor, 
          fontSize: 12.sp, 
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
            borderSide: BorderSide(color: AppColor.greyColor,), // Set the color you prefer
            borderRadius: BorderRadius.circular(15.r),
          ),
          filled: true,
          fillColor: AppColor.greyColor,     
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            color: AppColor.semiDarkGreyColor, 
            fontSize: 12.sp, //18.sp
            fontWeight: FontWeight.w400 //w500
          ),
          //prefixIcon: widget.prefixIcon,             
          //suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}

