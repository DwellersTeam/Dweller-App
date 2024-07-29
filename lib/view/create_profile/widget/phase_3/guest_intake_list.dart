import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class GuestIntakeList extends StatefulWidget {
  const GuestIntakeList({super.key,});

  @override
  State<GuestIntakeList> createState() => _GuestIntakeListState();
}

class _GuestIntakeListState extends State<GuestIntakeList> {

  final createProfileController = Get.put(CreateProfileController());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 210.h,
      height: 50.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        itemCount: createProfileController.guestintakeitems.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 10.w,),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                createProfileController.showNextBotton.value = true;
                createProfileController.selectedGuestIntakeIndex = index;
                print(createProfileController.selectedGuestIntakeIndex);
                createProfileController.onGuestIntakeSelected(index: createProfileController.selectedGuestIntakeIndex);
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              height: 40.h,
              //width: 150.w, //110.w
              //width: index.isEven ? 80.w : 160.w,
              decoration: BoxDecoration(          
                color: createProfileController.selectedGuestIntakeIndex == index ? AppColor.blueColorOp : AppColor.greyColor,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: createProfileController.selectedGuestIntakeIndex == index ? AppColor.blackColor : AppColor.greyColor
                )
              ),
              child: Text(
                createProfileController.guestintakeitems[index],  //${index}
                style: GoogleFonts.poppins(
                  color: createProfileController.selectedGuestIntakeIndex == index ? AppColor.blackColorOp : AppColor.neutralBlackColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400
                ),
              )
            ),
          );
        }
      ),
    );
  }
}