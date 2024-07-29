import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/view/create_profile/widget/welcome_page/elevated_button.dart';
import 'package:dweller/view/home/widget/notification/notification_sheet.dart';
import 'package:dweller/view/main/mainpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class SeekerPhase5Page extends StatefulWidget {
  const SeekerPhase5Page({super.key, required this.firstname});
  final String firstname;

  @override
  State<SeekerPhase5Page> createState() => _SeekerPhase5PageState();
}

class _SeekerPhase5PageState extends State<SeekerPhase5Page> {

  final createProfileController = Get.put(CreateProfileController());
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: CustomPaint(
          painter: RedSectionPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h,),    
              //HEADER
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        notificationBottomsheet(context: context);  
                      },
                      child: SvgPicture.asset('assets/svg/noti_icon.svg')
                    ),

                    createProfileController.imageUrlController.text.isEmpty ?
                    CircleAvatar(
                      radius: 24.r,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                      child: Text(
                        getFirstLetter(widget.firstname),
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                    :CircleAvatar(
                      radius: 24.r,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      backgroundImage: NetworkImage(createProfileController.imageUrlController.text),
                    ),
                  ],
                ),
              ),
          
              SizedBox(height: size.height * 0.04,),
          
              LinearProgressIndicator(
                backgroundColor: AppColor.blueColor.withOpacity(0.3), // Background color of the progress indicator
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.purpleColor), // Color of the progress indicator
                value: 1, // Value between 0.0 and 1.0 indicating the progress
                minHeight: 2.5,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(10.r)),
              ),
            
              SizedBox(height: size.height * 0.17,),
            
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Bravo ${widget.firstname}!\n",
                      style: GoogleFonts.bricolageGrotesque(
                        color: AppColor.darkPurpleColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    TextSpan(
                      text: "You're all done!",
                      style: GoogleFonts.bricolageGrotesque(
                        color: AppColor.darkPurpleColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ]
                )
              ),
              //Stacked Avatar List,
              SizedBox(height: size.height * 0.03,),
              Image.asset('assets/images/dwellers.png', filterQuality: FilterQuality.medium,),
              SizedBox(height: size.height * 0.03,),
                  
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'There are roommies ready to match\n',
                      style: GoogleFonts.poppins(
                        color: AppColor.darkPurpleColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    TextSpan(
                      text: 'with you',
                      style: GoogleFonts.poppins(
                        color: AppColor.darkPurpleColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                        
                  ]
                )
              ),
                      
              SizedBox(height: size.height * 0.05,),

              CustomElevatedButton(
                buttonColor: AppColor.darkPurpleColor,
                textColor: AppColor.whiteColor,
                text: "It's Go time!",
                onPressed: () {
                  Get.offAll(() => MainPage());
                },
              ),
                  
            ],
          ),
        ),
      ),
    );
  }
}



