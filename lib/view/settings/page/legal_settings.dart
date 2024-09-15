import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/view/settings/widget/legal/legal_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';









class LegalSettings extends StatelessWidget {
  const LegalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: CustomPaint(
          painter: TopRedSectionPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //appbar
              DwellerAppBar(
                //actionIcon: SvgPicture.asset('assets/svg/settings_icon.svg'),
              ),
              //SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Legal',
                  style: GoogleFonts.bricolageGrotesque(
                    color: AppColor.darkPurpleColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h), 
                child: LegalSelector(
                  onPressed: () {},
                  text: "Terms of Service"
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h), 
                child: LegalSelector(
                  onPressed: () {},
                  text: "Privacy Policy"
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h), 
                child: LegalSelector(
                  onPressed: () {},
                  text: "Community Guidelines"
                ),
              ),
              
            ]
          ),
        )
      )
    );
  }
}