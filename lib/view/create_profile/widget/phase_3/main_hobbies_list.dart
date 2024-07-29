import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class MainHobbiesList extends StatefulWidget {
  const MainHobbiesList({super.key,});

  @override
  State<MainHobbiesList> createState() => _MainHobbiesListState();
}

class _MainHobbiesListState extends State<MainHobbiesList> {

  final createProfileController = Get.put(CreateProfileController());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.h, //200.h
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 30, //10,
          mainAxisSpacing: 20, //10,
          childAspectRatio: 0.35, //0.3 Adjust this ratio as needed to control the item size
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: createProfileController.mainHobbiesList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                if (createProfileController.selectedMainHobbiesList.contains(createProfileController.mainHobbiesList[index])) {
                  createProfileController.selectedMainHobbiesList.remove(createProfileController.mainHobbiesList[index]);
                  debugPrint("selected hobbies: ${createProfileController.selectedMainHobbiesList}");
                } 
                else {
                  createProfileController.selectedMainHobbiesList.add(createProfileController.mainHobbiesList[index]);
                  debugPrint("selected hobbies: ${createProfileController.selectedMainHobbiesList}");
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              height: 40.h,
              //width: 180.w,
              //width: index.isEven ? 80.w : 160.w,
              decoration: BoxDecoration(          
                color: createProfileController.selectedMainHobbiesList.contains(createProfileController.mainHobbiesList[index]) ? AppColor.blueColorOp : AppColor.greyColor,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: createProfileController.selectedMainHobbiesList.contains(createProfileController.mainHobbiesList[index]) ? AppColor.blackColor : AppColor.greyColor
                )
              ),
              child: Text(
                createProfileController.mainHobbiesList[index],  //${index}
                style: GoogleFonts.poppins(
                  color: createProfileController.selectedMainHobbiesList.contains(createProfileController.mainHobbiesList[index]) ? AppColor.blackColorOp : AppColor.neutralBlackColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            ),
          );
        }
      ),
    );
  }
}