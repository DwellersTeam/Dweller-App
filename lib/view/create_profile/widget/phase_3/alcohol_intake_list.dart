import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class AlcoholIntakeList extends StatefulWidget {
  const AlcoholIntakeList({super.key,});

  @override
  State<AlcoholIntakeList> createState() => _AlcoholIntakeListState();
}

class _AlcoholIntakeListState extends State<AlcoholIntakeList> {

  final createProfileController = Get.put(CreateProfileController());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 160.h,
      height: 50.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        itemCount: createProfileController.alcoholintakeitems.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 10.w,),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                createProfileController.selectedAlcoholIntakeIndex = index;
                print(createProfileController.selectedAlcoholIntakeIndex);
                createProfileController.onAlcoholIntakeSelected(index: createProfileController.selectedAlcoholIntakeIndex);
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              height: 40.h,
              //width: 150.w, //110.w
              //width: index.isEven ? 80.w : 160.w,
              decoration: BoxDecoration(          
                color: createProfileController.selectedAlcoholIntakeIndex == index ? AppColor.blueColorOp : AppColor.greyColor,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: createProfileController.selectedAlcoholIntakeIndex == index ? AppColor.blackColor : AppColor.greyColor
                )
              ),
              child: Text(
                createProfileController.alcoholintakeitems[index],  //${index}
                style: GoogleFonts.poppins(
                  color: createProfileController.selectedAlcoholIntakeIndex == index ? AppColor.blackColorOp : AppColor.neutralBlackColor,
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