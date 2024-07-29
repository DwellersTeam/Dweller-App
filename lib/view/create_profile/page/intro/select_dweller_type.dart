import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/view/create_profile/page/phase_1/host_phase_1_.dart';
import 'package:dweller/view/create_profile/page/phase_1/seeker_phase_1.dart';
import 'package:dweller/view/create_profile/widget/select_dweller/dweller_type_list.dart';
import 'package:dweller/view/create_profile/widget/select_dweller/next_button.dart';
import 'package:dweller/view/home/widget/notification/notification_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';









class SelectDwellerPage extends StatelessWidget {
  SelectDwellerPage({super.key, required this.firstname, required this.authProvider});
  final String firstname;
  final String authProvider;

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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h,),    
                //HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        notificationBottomsheet(context: context);  
                      },
                      child: SvgPicture.asset('assets/svg/noti_icon.svg')
                    ),
                    CircleAvatar(
                      radius: 24.r,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      //backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                      child: Text(
                        getFirstLetter(firstname,),
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    
                  ],
                ),
              
                SizedBox(height: size.height * 0.12,),
              
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "What Kind of Dweller are you?",
                        style: GoogleFonts.bricolageGrotesque(
                          color: AppColor.blackColor,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      
                    ]
                  )
                ),
        
                SizedBox(height: size.height * 0.04,),
        
                //ListView builder
                const DwellerTypeList(),
        
                SizedBox(height: size.height * 0.15,),
        
                //NEXT BUTTON
                Obx(
                  () {
                    return CustomNextButton(
                      text: 'Next',
                      textColor: AppColor.whiteColor,
                      buttonColor: createProfileController.isDwellerSelected.value ? AppColor.darkPurpleColor : AppColor.darkPurpleColor.withOpacity(0.4),
                      onPressed: createProfileController.isDwellerSelected.value ? () {
                        if(createProfileController.selectedDwellerType.text == "Host") {
                          //host
                          Get.to(() => HostPhase1Page(firstname: firstname, authProvider: authProvider,));
                        }
                        else {
                          //seeker
                          Get.to(() => SeekerPhase1Page(firstname: firstname, authProvider: authProvider,));
                        }
                      } 
                      :() {
                        debugPrint("nothing. please select dweller type");
                      },
                    );
                  }
                )
        
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}



