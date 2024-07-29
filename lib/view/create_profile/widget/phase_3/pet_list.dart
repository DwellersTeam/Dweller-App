import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class PetsList extends StatefulWidget {
  const PetsList({super.key,});

  @override
  State<PetsList> createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {

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
        itemCount: createProfileController.petsitems.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 10.w,),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                createProfileController.selectedPetsIndex = index;
                print(createProfileController.selectedPetsIndex);
                createProfileController.onPetsSelected(index: createProfileController.selectedPetsIndex);
                //checks for dweller 
                if(createProfileController.selectedPetsController.text == "More") {
                  createProfileController.showMorePets.value = true; //!createProfileController.showMoreLivelihood.value;
                }
                else{
                  createProfileController.showMorePets.value = false;
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              height: 40.h,
              //width: 90.w, //110.w
              //width: index.isEven ? 80.w : 160.w,
              decoration: BoxDecoration(          
                color: createProfileController.selectedPetsIndex == index ? AppColor.blueColorOp : AppColor.greyColor,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: createProfileController.selectedPetsIndex == index ? AppColor.blackColor : AppColor.greyColor
                )
              ),
              child: Text(
                createProfileController.petsitems[index],  //${index}
                style: GoogleFonts.poppins(
                  color: createProfileController.selectedPetsIndex == index ? AppColor.blackColorOp : AppColor.neutralBlackColor,
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