import 'package:country_code_picker/country_code_picker.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';





class CountryCodeWidget extends StatefulWidget {
  const CountryCodeWidget({super.key, required this.onCountryChanged});
  final void Function(CountryCode) onCountryChanged;

  @override
  State<CountryCodeWidget> createState() => _CountryCodeWidgetState();
}

class _CountryCodeWidgetState extends State<CountryCodeWidget> {

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      onChanged: (val) {
        widget.onCountryChanged(val);
      }, //_onCountryChange,
      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
      initialSelection: 'NG',
      //backgroundColor: AppColor.whiteColor,
      textStyle: GoogleFonts.poppins(color: AppColor.semiDarkGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
      dialogTextStyle: GoogleFonts.poppins(color: AppColor.blackColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColor.whiteColor
      ),
      favorite: const ['NG'],
      // optional. Shows only country name and flag
      //showCountryOnly: false,
      // optional. Shows only country name and flag when popup is closed.
      //showOnlyCountryWhenClosed: false,
      // optional. aligns the flag and the Text left
      //alignLeft: true,
      //showDropDownButton: true,
      //showFlag: true,
    );
  }
}