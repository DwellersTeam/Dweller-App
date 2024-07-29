import 'dart:developer';
import 'package:dweller/services/controller/search/searchpage_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class FilterPetsList extends StatefulWidget {
  const FilterPetsList({super.key,});

  @override
  State<FilterPetsList> createState() => _FilterPetsListState();
}
class _FilterPetsListState extends State<FilterPetsList> {

  final searchPageController = Get.put(SearchPageController());
  
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
        //padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        itemCount: searchPageController.petList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 10.w,),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                searchPageController.selectedPetsIndex = index;
                log("${searchPageController.selectedPetsIndex}");
                searchPageController.onPetsSelected(index: searchPageController.selectedPetsIndex);
                //checks for dweller 
                if(searchPageController.selectedPetController.text == "Others") {
                  log('Other Pets');
                }
                else{
                  log('Normal People');
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
                color: searchPageController.selectedPetsIndex == index ? AppColor.blueColor : AppColor.greyColor,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: searchPageController.selectedPetsIndex == index ? AppColor.blueColor: AppColor.greyColor
                )
              ),
              child: Text(
                searchPageController.petList[index],  //${index}
                style: GoogleFonts.poppins(
                  color: searchPageController.selectedPetsIndex == index ? AppColor.whiteColor : AppColor.neutralBlackColor,
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